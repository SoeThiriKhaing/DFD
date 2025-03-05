import 'package:dailyfairdeal/config/messages.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
import 'package:marquee/marquee.dart';

class TaxiHome extends StatefulWidget {
  const TaxiHome({super.key});

  @override
  State<TaxiHome> createState() => _TaxiHomeState();
}

class _TaxiHomeState extends State<TaxiHome> {
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  GoogleMapController? mapController;
  LatLng? sourceLocation;
  LatLng? destinationLocation;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  String googleAPIKey = "AIzaSyAXBWwV59Q5OlaUZ1TQs-j6YXgp_7cqHPA";
  Location location = Location();
  LatLng? currentLocation;
  bool isLoading = false;
  bool showDriverList = false;
  bool showSearchFields = true;

  // List<Map<String, dynamic>> nearbyTaxiDriver = [
  //   {'driverName': 'John Doe', 'carNo': 'ABC123', 'price': '10 USD'},
  //   {'driverName': 'Jane Smith', 'carNo': 'XYZ456', 'price': '12 USD'},
  // ];

  List<Map<String, dynamic>> nearbyTaxiDriver = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((_) {
      if (currentLocation != null) {
        sourceController.text = 'Current Location';
        sourceLocation = currentLocation;
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentLocation!,
              zoom: 14.0,
            ),
          ),
        );
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getCurrentLocation() async {
    final locData = await location.getLocation();
    setState(() {
      currentLocation = LatLng(locData.latitude!, locData.longitude!);
    });
  }

  Future<void> _searchDrivers() async {
    if (sourceLocation != null) {
      setState(() {
        isLoading = true;
        showDriverList = false;
      });
      final response = await http.post(
        Uri.parse('https://api.example.com/nearby-drivers'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'lat': sourceLocation!.latitude,
          'long': sourceLocation!.longitude,
          'radius': 1,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('API Response: ${response.body}');
        nearbyTaxiDriver = json.decode(response.body);
      } else {
        debugPrint('Failed to fetch drivers');
        nearbyTaxiDriver = [];
      }
      setState(() {
        isLoading = false;
        showDriverList = true;
      });
    }
  }

  Widget sourceAutoComplete() {
    return Stack(
      children: [
        GooglePlaceAutoCompleteTextField(
          textEditingController: sourceController,
          googleAPIKey: googleAPIKey,
          inputDecoration: InputDecoration(
            labelText: 'Source',
            labelStyle: const TextStyle(fontSize: 14.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          ),
          debounceTime: 800,
          countries: const ["MM"],
          isLatLngRequired: true,
          showError: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            setState(() {
              sourceLocation = LatLng(
                double.parse(prediction.lat!),
                double.parse(prediction.lng!),
              );
              debugPrint("Source Location: $sourceLocation");
            });
          },
          itemClick: (Prediction prediction) {
            sourceController.text = prediction.description!;
            sourceController.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length),
            );
          },
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                sourceController.clear();
                sourceLocation = null;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget destinationAutoComplete() {
    return Stack(
      children: [
        GooglePlaceAutoCompleteTextField(
          textEditingController: destinationController,
          googleAPIKey: googleAPIKey,
          inputDecoration: InputDecoration(
            labelText: 'Destination',
            labelStyle: const TextStyle(fontSize: 14.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          ),
          debounceTime: 800,
          countries: const ["MM"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            setState(() {
              destinationLocation = LatLng(
                double.parse(prediction.lat!),
                double.parse(prediction.lng!),
              );
              debugPrint("Destination Location: $destinationLocation");
            });
          },
          itemClick: (Prediction prediction) {
            destinationController.text = prediction.description!;
            destinationController.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length),
            );
          },
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                destinationController.clear();
                destinationLocation = null;
              });
            },
          ),
        ),
      ],
    );
  }

  Future<void> _getRoute() async {
    if (sourceLocation != null && destinationLocation != null) {
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=${sourceLocation!.latitude},${sourceLocation!.longitude}&destination=${destinationLocation!.latitude},${destinationLocation!.longitude}&key=$googleAPIKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'].isNotEmpty) {
          final points = data['routes'][0]['overview_polyline']['points'];
          final List<LatLng> polylinePoints = _decodePolyline(points);

          setState(() {
            polylines.clear();
            polylines.add(
              Polyline(
                polylineId: const PolylineId("route"),
                points: polylinePoints,
                color: Colors.blue,
                width: 5,
              ),
            );
          });
        } else {
          debugPrint('No routes found');
        }
      } else {
        debugPrint('Failed to fetch route');
      }
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  void _setPolylineAndMarkers() {
    if (sourceLocation != null && destinationLocation != null) {
      markers.clear();

      markers.add(
        Marker(
          markerId: const MarkerId("source"),
          position: sourceLocation!,
          infoWindow: const InfoWindow(title: "Source"),
        ),
      );

      markers.add(
        Marker(
          markerId: const MarkerId("destination"),
          position: destinationLocation!,
          infoWindow: const InfoWindow(title: "Destination"),
        ),
      );

      _getRoute();
    }
  }

  void _moveToCurrentLocation() {
    _getCurrentLocation().then((_) {
      if (currentLocation != null) {
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentLocation!,
              zoom: 14.0,
            ),
          ),
        );

        setState(() {
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taxi Booking', style: AppWidget.appBarTextStyle(),),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Visibility(
            visible: showSearchFields,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  sourceAutoComplete(),
                  const SizedBox(height: 6.0),
                  destinationAutoComplete(),
                  const SizedBox(height: 6.0),
                  ElevatedButton(
                    onPressed: () {
                      if (sourceLocation == null) {
                        SnackbarHelper.showSnackbar(
                          title: 'Error',
                          message: ErrorMessage.typeSource,
                          backgroundColor: Colors.red,
                        );
                        return;
                      }
                      if (destinationLocation == null) {
                        SnackbarHelper.showSnackbar(
                          title: 'Error',
                          message: ErrorMessage.typeDestination,
                          backgroundColor: Colors.red,
                        );
                        return;
                      }
                      _setPolylineAndMarkers();
                      if (sourceLocation != null && destinationLocation != null) {
                        mapController?.animateCamera(
                          CameraUpdate.newLatLngBounds(
                            LatLngBounds(
                              southwest: LatLng(
                                sourceLocation!.latitude < destinationLocation!.latitude
                                    ? sourceLocation!.latitude
                                    : destinationLocation!.latitude,
                                sourceLocation!.longitude < destinationLocation!.longitude
                                    ? sourceLocation!.longitude
                                    : destinationLocation!.longitude,
                              ),
                              northeast: LatLng(
                                sourceLocation!.latitude > destinationLocation!.latitude
                                    ? sourceLocation!.latitude
                                    : destinationLocation!.latitude,
                                sourceLocation!.longitude > destinationLocation!.longitude
                                    ? sourceLocation!.longitude
                                    : destinationLocation!.longitude,
                              ),
                            ),
                            50.0,
                          ),
                        );
                      }
                      //_searchDrivers();
                      isLoading = false; //For Testing
                      showDriverList = true; //For Testing
                      setState(() {
                        showSearchFields = false;
                      });
                    },
                    child: const Text('Search', style: TextStyle(fontSize: 14.0)),
                  ),
                ],
              ),
            ),
          ),
          if (!showSearchFields)
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 30.0,
                  child: Marquee(
                    text: 'From: ${sourceController.text.length > 20 ? '${sourceController.text.substring(0, 20)}...' : sourceController.text} To: ${destinationController.text.length > 20 ? '${destinationController.text.substring(0, 20)}...' : destinationController.text}',
                    style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                    scrollAxis: Axis.horizontal,
                    blankSpace: 20.0,
                    velocity: 30.0,
                    pauseAfterRound: const Duration(seconds: 1),
                    startPadding: 10.0,
                    showFadingOnlyWhenScrolling: true,
                    fadingEdgeStartFraction: 0.1,
                    fadingEdgeEndFraction: 0.1,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  onPressed: () {
                    setState(() {
                      showSearchFields = true;
                    });
                  },
                ),
              ],
            ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: currentLocation ?? const LatLng(16.8409, 96.1735),
                    zoom: 14.0,
                  ),
                  markers: markers,
                  polylines: polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  onCameraMove: (CameraPosition position) {
                    setState(() {
                      currentLocation = position.target;
                    });
                  },
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  bottom: 100,
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: _moveToCurrentLocation,
                    child: const Icon(Icons.my_location),
                  ),
                ),
              ],
            ),
          ),
          
          if (showDriverList)
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Nearby Taxi Drivers',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : nearbyTaxiDriver.isEmpty
                            ? const Center(child: Text('No nearby drivers found.'))
                            : ListView.builder(
                                itemCount: nearbyTaxiDriver.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final driver = nearbyTaxiDriver[index];
                                  return ListTile(
                                    title: Text(driver['driverName']),
                                    subtitle: Text('Car No: ${driver['carNo']} \nPrice: ${driver['price']}'),
                                    trailing: ElevatedButton(
                                      onPressed: () {
                                        // Handle accept button press
                                      },
                                      child: const Text('Accept'),
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
