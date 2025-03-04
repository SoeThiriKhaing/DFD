import 'package:dailyfairdeal/config/messages.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

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

  List<Map<String, dynamic>> nearbyTaxiDriver = [
    {'driverName': 'John Doe', 'carNo': 'ABC123', 'price': '10 USD'},
    {'driverName': 'Jane Smith', 'carNo': 'XYZ456', 'price': '12 USD'},
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
        setState(() {});
      } else {
        debugPrint('Failed to fetch drivers');
      }
    }
  }

  void _showNearbyDrivers() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nearby Taxi Drivers'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: nearbyTaxiDriver.length,
              itemBuilder: (BuildContext context, int index) {
                final driver = nearbyTaxiDriver[index];
                return ListTile(
                  title: Text(driver['driverName']),
                  subtitle: Text('Car No: ${driver['carNo']} - Price: ${driver['price']}'),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                sourceAutoComplete(),
                const SizedBox(height: 8.0),
                destinationAutoComplete(),
                const SizedBox(height: 8.0),
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
                    //_searchDrivers().then((_) {
                      _showNearbyDrivers();
                    //});
                  },
                  child: const Text('Search', style: TextStyle(fontSize: 14.0)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(16.8409, 96.1735),
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
        ],
      ),
    );
  }
}
