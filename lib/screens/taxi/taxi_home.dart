import 'dart:convert';
import 'package:dailyfairdeal/controllers/taxi/driver/nearby_taxi_driver_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/travel/travel_controller.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/nearby_taxi_driver_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:dailyfairdeal/screens/taxi/widgets/auto_complete_text_field.dart';
import 'package:dailyfairdeal/screens/taxi/widgets/driver_list.dart';
import 'package:dailyfairdeal/screens/taxi/widgets/map_view.dart';
import 'package:dailyfairdeal/services/taxi/driver/nearby_taxi_driver_service.dart';
import 'package:dailyfairdeal/services/taxi/travel/travel_service.dart';
import 'package:dailyfairdeal/services/taxi/location/location_service.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:dailyfairdeal/config/messages.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';

class TaxiHome extends StatefulWidget {
  const TaxiHome({super.key});

  @override
  State<TaxiHome> createState() => _TaxiHomeState();
}

class _TaxiHomeState extends State<TaxiHome> {
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final LocationService locationService = LocationService();
  final NearByTaxiDriverRepository repository = NearByTaxiDriverRepository();
  late NearByTaxiDriverService service;
  late NearByTaxiDriverController controller;
  GoogleMapController? mapController;
  LatLng? sourceLocation;
  LatLng? destinationLocation;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  LatLng? currentLocation;
  bool isLoading = false;
  bool showDriverList = false;
  bool showSearchFields = true;
  List<Map<String, String?>> nearbyTaxiDriver = [];
  int? travelId;
  String googleAPIKey = "AIzaSyAXBWwV59Q5OlaUZ1TQs-j6YXgp_7cqHPA";
  final TravelController travelController = Get.put(TravelController(
    travelService:TravelService(travelRepository: TravelRepository())));
  bool isSearchButtonEnabled = true;
  bool isCancelButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    service = NearByTaxiDriverService(repository: repository);
    controller = NearByTaxiDriverController(service: service);
    _getCurrentLocation();
  }

  //To Type Automatically Current Location in the Source Location Text Field at initial state
  Future<void> _getCurrentLocation() async {
    currentLocation = await locationService.getCurrentLocation();
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
  }

  Future<void> searchNearByTaxiDrivers() async {
    if (sourceLocation != null) {
      setState(() {
        isLoading = true;
        showDriverList = false;
      });
      try {
        TravelModel travel = TravelModel(
        pickupLatitude: sourceLocation!.latitude,
        pickupLongitude: sourceLocation!.longitude,
        destinationLatitude: destinationLocation!.latitude,
        destinationLongitude: destinationLocation!.longitude,
        status: 'pending',
      );
        Map<String, dynamic> response = await travelController.createTravelRequest(travel);
        String status = response['status'];
        String myTravelId = response['travelId'].toString();
        travelId = int.parse(myTravelId);
        List<Map<String, String?>> driversList = await controller.fetchNearbyDrivers();
        nearbyTaxiDriver = driversList;
        setState(() {
          isLoading = false;
          showDriverList = true;
          if (status == 'pending' || status == 'bidding') {
            isSearchButtonEnabled = false;
            isCancelButtonEnabled = true;
          } else if (status == 'accept') {
            isSearchButtonEnabled = false;
            isCancelButtonEnabled = true;
          }
        });
      } catch (e) {
        debugPrint('Failed to fetch drivers: $e');
        nearbyTaxiDriver = [];
      }
      
    }
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
                  AutoCompleteTextField(
                    controller: sourceController,
                    googleAPIKey: googleAPIKey,
                    labelText: 'Source',
                    onPlaceSelected: (Prediction prediction) {
                      setState(() {
                        sourceLocation = LatLng(
                          double.parse(prediction.lat!),
                          double.parse(prediction.lng!),
                        );
                        debugPrint("Source Location: $sourceLocation");
                      });
                    },
                    prefixIcon: const Icon(Icons.my_location, color: AppColor.primaryColor),
                  ),
                  const SizedBox(height: 6.0), // Reduced spacing
                  AutoCompleteTextField(
                    controller: destinationController,
                    googleAPIKey: googleAPIKey,
                    labelText: 'Destination',
                    onPlaceSelected: (Prediction prediction) {
                      setState(() {
                        destinationLocation = LatLng(
                          double.parse(prediction.lat!),
                          double.parse(prediction.lng!),
                        );
                        debugPrint("Destination Location: $destinationLocation");
                      });
                    }, 
                    prefixIcon: const Icon(Icons.location_on_sharp, color: AppColor.primaryColor),
                  ),
                  const SizedBox(height: 6.0), // Reduced spacing
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: isSearchButtonEnabled ? () async {
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
                          setState(() {
                            isSearchButtonEnabled = false;
                            isCancelButtonEnabled = true;
                          });
                          await searchNearByTaxiDrivers();
                        } : null,
                        child: const Text('Search', style: TextStyle(fontSize: 12.0)), // Reduced font size
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: isCancelButtonEnabled ? () async{
                          await travelController.deleteTravel(travelId!);
                          setState(() {
                            showSearchFields = false;
                            showDriverList = false;
                            isSearchButtonEnabled = true;
                            isCancelButtonEnabled = false;
                            sourceController.clear();
                            destinationController.clear();
                            polylines.clear();
                            markers.clear();
                          });
                        } : null,
                        child: const Text('Cancel', style: TextStyle(fontSize: 12.0)), // Reduced font size
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!showSearchFields)
            Column(
              children: [
                SizedBox(
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
                MapView(
                  initialPosition: currentLocation ?? const LatLng(16.8409, 96.1735),
                  markers: markers,
                  polylines: polylines,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  onCameraMove: (position) {
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
              child: DriverList(
                driversList: nearbyTaxiDriver,
                isLoading: isLoading,
              ),
            ),
        ],
      ),
    );
  }
}