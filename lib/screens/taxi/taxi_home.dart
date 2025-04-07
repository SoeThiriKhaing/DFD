import 'dart:async';
import 'dart:convert';
import 'package:dailyfairdeal/common_calls/constant.dart';
import 'package:dailyfairdeal/controllers/taxi/driver/driver_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/driver/get_nearby_taxi_driver_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/travel/travel_controller.dart';
import 'package:dailyfairdeal/main.dart';
import 'package:dailyfairdeal/models/taxi/travel/create_travel_model.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/driver_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/get_nearby_taxi_driver_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:dailyfairdeal/screens/taxi/widgets/auto_complete_text_field.dart';
import 'package:dailyfairdeal/screens/taxi/widgets/decode_polyline.dart';
import 'package:dailyfairdeal/screens/taxi/widgets/driver_list.dart';
import 'package:dailyfairdeal/screens/taxi/widgets/map_view.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_service.dart';
import 'package:dailyfairdeal/services/taxi/driver/get_nearby_taxi_driver_service.dart';
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
  State<TaxiHome> createState() => TaxiHomeState();
}

class TaxiHomeState extends State<TaxiHome> with RouteAware {
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final LocationService locationService = LocationService();
  final GetNearByTaxiDriverRepository repository = GetNearByTaxiDriverRepository();
  late GetNearByTaxiDriverService service;
  late GetNearByTaxiDriverController controller;
  GoogleMapController? mapController;
  LatLng? sourceLocation;
  LatLng? destinationLocation;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  LatLng? currentLocation;
  bool isLoading = false;
  bool showDriverList = false;
  bool showSelectedDriverInfo = false;
  bool showSearchFields = true;
  Map<String, String?> selectedDriverInfo = {};
  List<NearbyDriverModel> nearbyDrivers = []; //To check the nearby drivers is exist or not if the user search the taxi
  List<Map<String, String?>> nearbyTaxiDriver = [];
  int? travelId;
  Timer? locationUpdateTimer;
  final TravelController travelController = Get.put(TravelController(
    travelService:TravelService(travelRepository: TravelRepository())));
  final DriverController driverController = Get.put(DriverController(service: DriverService(repository: DriverRepository())));
  bool isSearchButtonEnabled = true;
  bool isCancelButtonEnabled = false;
  String? status; //To store trip status when serach nearby taxi driver
  bool showCompleteTrip = false; //To show the complete trip button

  late Timer _findNearByTaxiDriverTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute<dynamic>) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void didPop() {
    _deleteTrip(); // Call delete function when back button is pressed
    super.didPop();
  }

  Future<void> _deleteTrip() async {
    try {
      await travelController.deleteTravel(travelId!);
      setState(() {
        showSearchFields = true;
        showDriverList = false;
        isSearchButtonEnabled = true;
        isCancelButtonEnabled = false;
        showSelectedDriverInfo = false;
        sourceController.clear();
        destinationController.clear();
        polylines.clear();
        markers.clear();
        travelId = null;
        nearbyDrivers.clear();
        nearbyTaxiDriver.clear();
        showCompleteTrip = false;
        sourceLocation = null;
        destinationLocation = null;
        currentLocation = null;
      });
      Get.offNamed('/taxihome');
      SnackbarHelper.showSnackbar(
        title: 'Trip Cancelled',
        message: 'Your trip has been cancelled successfully.',
        backgroundColor: Colors.red,
      );
    } catch (e) {
      debugPrint("Failed to delete trip: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    service = GetNearByTaxiDriverService(repository: GetNearByTaxiDriverRepository());
    controller = GetNearByTaxiDriverController(service: service);
    _getCurrentLocation();
    Get.put(this); // Inject this instance
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _findNearByTaxiDriverTimer.cancel();
    locationUpdateTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _findNearByTaxiDriverTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {

      });
    });
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

  Future<void> fetchNearByTaxiDrivers() async {
    try {
      List<Map<String, String?>> driversList = await controller.fetchNearbyDrivers(travelId!);
        nearbyTaxiDriver = driversList;
    } catch (e) {
      debugPrint('Failed to fetch drivers: $e');
      nearbyTaxiDriver = [];
    }
  }

  Future<void> searchNearByTaxiDrivers() async {
    if (sourceLocation != null && destinationLocation != null) {
      setState(() {
        isLoading = true;
        showDriverList = true;
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
        status = response['status'];
        int myTravelId = response['travelId'];
        nearbyDrivers = List<NearbyDriverModel>.from(response["nearbyDriverList"]);
        debugPrint("Travel ID in User Taxi Home: $myTravelId");
        travelId = myTravelId;
        fetchNearByTaxiDrivers();
        setState(() {
          isLoading = false;
          showDriverList = true;
          if (status == 'pending' || status == 'bidding') {
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

  //After the rider accept the trip, update the polyline and marker from the rider to the driver and track driver location
  void updatePolylineAndMarker(Map<String, String?> driver) async {
    showDriverList = false; // Hide driver list
    showSearchFields = false; // Hide search fields
    isSearchButtonEnabled = false;
    isCancelButtonEnabled = false;
    showSelectedDriverInfo = true;
    showCompleteTrip = false;

    String driverId = driver['taxi_driver_id']!;
    String travelId = driver['travel_id']!; // Get travelId from driver data

    selectedDriverInfo = driver; // Store selected driver information globally

    // Check if trip is complete before proceeding
    bool isTripComplete = await travelController.checkTripComplete(int.parse(travelId));
    if (isTripComplete) {
      debugPrint("Trip is complete. Skipping polyline update.");
      setState(() {
        showCompleteTrip = true; // Show complete trip butto
      });
      return; // Exit function early
    }

    final response = await driverController.fetchTaxiDriverByDriverId(int.parse(driverId));

    if (response.id != null) {
      LatLng driverLocation = LatLng(response.latitude, response.longitude);

      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId("driver_${driver['taxi_driver_id']}"),
            position: driverLocation,
            infoWindow: InfoWindow(title: "Driver: ${driver['driver_name']} Location"),
          ),
        );

        // Update source and destination locations dynamically
        sourceLocation = driverLocation; // Set driver as the new source
      });

      // Move camera to the new driver location smoothly
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(driverLocation, 16),
      );

      // Call _getRoute() to dynamically fetch the route
      await _getRoute(Colors.green);

      // Update the polyline from the rider to the driver every 5 seconds
      locationUpdateTimer?.cancel(); // Cancel previous timer
      locationUpdateTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        // Re-check trip status before updating, true = trip is complete, false = trip is still active
        bool isTripStillActive = await travelController.checkTripComplete(int.parse(travelId));
        if (!isTripStillActive) {
          //if false, update the driver location
          updatePolylineAndMarker(driver);
        } else {
          //if true, trip is complete
          debugPrint("Trip is complete. Stopping updates.");
          showCompleteTrip = true; // Show complete trip button
          timer.cancel(); // Stop the periodic update
        }
      });
    } else {
      debugPrint("Driver location is not available");
    }
  }


  //For the rider search first time
  void _setPolylineAndMarkers() {
    if (sourceLocation != null && destinationLocation != null) {
      markers.clear();

      markers.add(
        Marker(
          markerId: const MarkerId("source"),
          position: sourceLocation!,
          infoWindow: const InfoWindow(title: "Your Source Location"),
        ),
      );

      markers.add(
        Marker(
          markerId: const MarkerId("destination"),
          position: destinationLocation!,
          infoWindow: const InfoWindow(title: "Your Destination Location"),
        ),
      );

      _getRoute(Colors.blue);
    }
  }

  Future<void> _getRoute(Color polylineColor) async {
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
          final List<LatLng> polylinePoints = decodePolyline(points);

          setState(() {
            polylines.add(
              Polyline(
                polylineId: const PolylineId("route"),
                points: polylinePoints,
                color: polylineColor,
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

  Future <void> checkCompleteTrip(int tripId)async {
    try {
      bool response = await travelController.checkTripComplete(tripId);
      if (response == true) {
        debugPrint('Trip completed successfully');
        setState(() {
          showCompleteTrip = true;
        });
      } else {
        debugPrint('Failed to check trip completion');
        showCompleteTrip = false;
      }
    } catch (e) {
      debugPrint('Error checking trip completion: $e');
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
                          showSearchFields = false;
                          isCancelButtonEnabled = true;
                        });
                        await searchNearByTaxiDrivers();
                      } : null,
                      child: const Text('Search', style: TextStyle(fontSize: 12.0)), // Reduced font size
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                      onPressed: isCancelButtonEnabled ? () async {
                        final confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text('Are you sure you want to cancel the trip?'),
                          actions: [
                            TextButton(
                            onPressed: () => Get.back(result: false),
                            child: const Text('No'),
                            ),
                            TextButton(
                            onPressed: () => Get.back(result: true),
                            child: const Text('Yes'),
                            ),
                          ],
                          );
                        },
                        );
    
                        if (confirm == true) {
                        locationUpdateTimer?.cancel(); // Stop live tracking
                        _deleteTrip(); // Delete the trip
                        }
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
          
          if (showDriverList)...[
            if(nearbyDrivers.isNotEmpty) ...[
              Expanded(
                child: DriverList(
                  driversList: nearbyTaxiDriver,
                  isLoading: isLoading,
                  onDriverAccepted: (driver) {
                    setState(() {
                      isLoading = true; // Show loading indicator while waiting for driver response
                    });

                    // Simulate waiting for driver response
                    Future.delayed(const Duration(seconds: 3), () {
                      setState(() {
                        isLoading = false; // Hide loading indicator after response
                      });
                      // If the driver accepts, update polyline and marker
                      updatePolylineAndMarker(driver);
                      travelId = int.tryParse(driver['travel_id'] ?? '');
                      checkCompleteTrip(travelId!);
                    });
                  },
                ),
              ),
            ]
            else ...[
              const SizedBox(
                height: 100.0,
                child: Center(child: Text('No nearby drivers found.')),
              ),
            ],
          ],
    
          //To Show Driver Information containing Name, License Plate, Phone Number, and Bid Price, and the feedback from the rider
          if(showSelectedDriverInfo)
            //Driver Information
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Added Avatar for the driver
                  const CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Driver Information', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text('Name: ', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                      Text("${selectedDriverInfo['driver_name']}", style: const TextStyle(fontSize: 14.0)),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Text('License Plate: ', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                      Text("${selectedDriverInfo['license_plate']}", style: const TextStyle(fontSize: 14.0)),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Text('Phone Number: ', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                      Text("${selectedDriverInfo['driver_phone']}", style: const TextStyle(fontSize: 14.0)),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Text('Price: ', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                      Text("${selectedDriverInfo['price']} MMK", style: const TextStyle(fontSize: 14.0)),
                    ],
                  ),
                  if(showCompleteTrip)
                    const SizedBox(height: 8.0),
                    //Button for Complete the Trip
                    ElevatedButton(
                      onPressed: () {
                        //Clear all the data
                        setState(() {
                          showSearchFields = true;
                          showDriverList = false;
                          isSearchButtonEnabled = true;
                          isCancelButtonEnabled = false;
                          showSelectedDriverInfo = false;
                          sourceController.clear();
                          destinationController.clear();
                          sourceLocation = null;
                          destinationLocation = null;
                          currentLocation = null;
                          polylines.clear();
                          markers.clear();
                          showCompleteTrip = false;
                          sourceController.clear();
                          destinationController.clear();
                          travelId = null;
                          nearbyDrivers.clear();
                          nearbyTaxiDriver.clear();
                          selectedDriverInfo.clear();
                        });
                        SnackbarHelper.showSnackbar(
                          title: 'Trip Completed',
                          message: 'Thank you for using our service!',
                          backgroundColor: Colors.green,
                        );
                        Get.offNamed('/taxihome');
                      },
                      child: const Text('Complete Trip', style: TextStyle(fontSize: 12.0)), // Reduced font size
                    ),
                ],
              ),
            )
          
        ]
      ),
    );
  }
}