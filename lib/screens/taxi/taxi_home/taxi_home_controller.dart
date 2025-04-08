import 'dart:async';
import 'dart:convert';
import 'package:dailyfairdeal/common_calls/constant.dart';
import 'package:dailyfairdeal/controllers/taxi/driver/accept_driver_rider_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/driver/driver_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/travel/travel_controller.dart';
import 'package:dailyfairdeal/models/taxi/driver/accept_driver_ride_model.dart';
import 'package:dailyfairdeal/models/taxi/travel/create_travel_model.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/driver_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/get_nearby_taxi_driver_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:dailyfairdeal/screens/taxi/widgets/decode_polyline.dart';
import 'package:dailyfairdeal/services/taxi/driver/accept_driver_ride_service.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_service.dart';
import 'package:dailyfairdeal/services/taxi/driver/get_nearby_taxi_driver_service.dart';
import 'package:dailyfairdeal/services/taxi/location/location_service.dart';
import 'package:dailyfairdeal/services/taxi/travel/travel_service.dart';
import 'package:dailyfairdeal/controllers/taxi/driver/get_nearby_taxi_driver_controller.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../repositories/taxi/driver/accept_driver_ride_repository.dart';

class TaxiHomeController extends ChangeNotifier {
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
  
  bool isSearchButtonEnabled = true;
  bool isCancelButtonEnabled = false;
  String? status; //To store trip status when serach nearby taxi driver
  bool showCompleteTrip = false; //To show the complete trip button

  //Controller
  TravelController travelController = Get.put(TravelController(travelService:TravelService(travelRepository: TravelRepository())));
  DriverController driverController = Get.put(DriverController(service: DriverService(repository: DriverRepository())));
  GetNearByTaxiDriverController getNearbyTaxiDriverController = Get.put(GetNearByTaxiDriverController(service: GetNearByTaxiDriverService(repository: GetNearByTaxiDriverRepository())));
  AcceptDriverRideController acceptDriverByRiderController = Get.put(AcceptDriverRideController(service: AcceptDriverRideService(repository: AcceptDriverRideRepository())));

  Timer? _searchNearbyTaxiDriverTimer;

  // Start searching for nearby taxi drivers and call the API every 5 seconds
  void startSearchingForDrivers() {
    if (_searchNearbyTaxiDriverTimer != null) {
      // If a timer is already running, cancel it first.
      _searchNearbyTaxiDriverTimer?.cancel();
    }

    // Trigger API call every 5 seconds (adjust the interval if needed)
    _searchNearbyTaxiDriverTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchNearByTaxiDrivers();
    });
    notifyListeners();
  }

  // Stop the API search
  void stopSearchingForDrivers() {
    _searchNearbyTaxiDriverTimer?.cancel();
    notifyListeners();
  }

  // Dispose the timer when no longer needed
  @override
  void dispose() {
    _searchNearbyTaxiDriverTimer?.cancel();
    super.dispose();
  }

  // Method to fetch and update the current location
  Future<void> getCurrentLocation() async {
    currentLocation = await locationService.getCurrentLocation(); // Assuming locationService is set up
    
    if (currentLocation != null) {
      // Set the source field to 'Current Location'
      sourceController.text = 'Current Location'; 
      
      // Move the map camera to the current location
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLocation!,
            zoom: 14.0,
          ),
        ),
      );

      // Save the LatLng as sourceLocation
      sourceLocation = currentLocation; 

      // Notify listeners to update the UI
      notifyListeners();
    }
  }


  //Delete trip
  Future<void> deleteTrip() async {
    try {
      await travelController.deleteTravel(travelId!);

      // Reset all states
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

      // Notify UI
      notifyListeners();

      // Navigate and show feedback
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

  Future<void> fetchNearByTaxiDrivers() async {
    try {
      List<Map<String, String?>> driversList = await getNearbyTaxiDriverController.fetchNearbyDrivers(travelId!);
        nearbyTaxiDriver = driversList;
    } catch (e) {
      debugPrint('Failed to fetch drivers: $e');
      nearbyTaxiDriver = [];
    }
  }

  Future<void> searchNearByTaxiDrivers() async {
    if (sourceLocation != null && destinationLocation != null) {

        isLoading = true;
        showDriverList = true;
        notifyListeners();
        
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
        
        isLoading = false;
        showDriverList = true;
        notifyListeners();

        if (status == 'pending' || status == 'bidding') {
          isSearchButtonEnabled = false;
          isCancelButtonEnabled = true;
          notifyListeners();
        }
      
      } catch (e) {
        debugPrint('Failed to fetch drivers: $e');
        nearbyTaxiDriver = [];
      } 
    }
  }

  Future <void> checkCompleteTrip(int tripId)async {
    try {
      bool response = await travelController.checkTripComplete(tripId);
      if (response == true) {
        debugPrint('Trip completed successfully');
       
        showCompleteTrip = true;
        notifyListeners();
        
      } else {
        debugPrint('Failed to check trip completion');
        showCompleteTrip = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error checking trip completion: $e');
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getRoute(Color polylineColor) async {
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

          polylines.add(
            Polyline(
              polylineId: const PolylineId("route"),
              points: polylinePoints,
              color: polylineColor,
              width: 5,
            ),
          );
          notifyListeners();
          
        } else {
          debugPrint('No routes found');
        }
      } else {
        debugPrint('Failed to fetch route');
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
      
      showCompleteTrip = true; // Show complete trip button
      notifyListeners();
      
      return; // Exit function early
    }

    final response = await driverController.fetchTaxiDriverByDriverId(int.parse(driverId));

    if (response.id != null) {
      LatLng driverLocation = LatLng(response.latitude, response.longitude);

      markers.add(
        Marker(
          markerId: MarkerId("driver_${driver['taxi_driver_id']}"),
          position: driverLocation,
          infoWindow: InfoWindow(title: "Driver: ${driver['driver_name']} Location"),
        ),
      );

      // Update source and destination locations dynamically
      sourceLocation = driverLocation; // Set driver as the new source
      notifyListeners();

      // Move camera to the new driver location smoothly
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(driverLocation, 16),
      );

      // Call _getRoute() to dynamically fetch the route
      await getRoute(Colors.green);

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
  void setPolylineAndMarkers() {
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

      getRoute(Colors.blue);
    }
  }

  void moveToCurrentLocation() {
    getCurrentLocation(); // Call the method to update current location when needed
  }

  void setSourceLocation(Prediction prediction) {
    sourceLocation = LatLng(
      double.parse(prediction.lat!),
      double.parse(prediction.lng!),
    );
    sourceController.text = prediction.description!;
    notifyListeners();
  }

  void setDestinationLocation(Prediction prediction) {
    destinationLocation = LatLng(
      double.parse(prediction.lat!),
      double.parse(prediction.lng!),
    );
    destinationController.text = prediction.description!;
    notifyListeners();
  }

  Future<void> clickSearchButton() async{
    setPolylineAndMarkers();
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

      isSearchButtonEnabled = false;
      showSearchFields = false;
      isCancelButtonEnabled = true;
      notifyListeners();

      await searchNearByTaxiDrivers();
  }

  Future<void> clickCancleButton() async{
    locationUpdateTimer?.cancel(); // Stop live tracking
    deleteTrip(); // Delete the trip
  }

  void setShowSearchFields(bool value) {
    showSearchFields = value;
    notifyListeners();
  }

  void updateCameraPosition(CameraPosition position) {
    currentLocation = position.target;
    notifyListeners();
  }

  void setLoadingStatus(bool bool) {
    isLoading = bool;
    notifyListeners();
  }

  Future<void> setCompleteTrip() async{
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
    travelId = null;
    nearbyDrivers.clear();
    nearbyTaxiDriver.clear();
    selectedDriverInfo.clear();
    notifyListeners();
  }

  //When the rider click accept button from the nearby driver list
  //To accept the driver and show the driver info
  Future<void> handleDriverAcceptance(
    int? driverId,
    int? travelId,
    double? price,
    Map<String, String?> driver,
    Function(Map<String, String?>) onSuccess,
  ) async {
    if (driverId == null || travelId == null || price == null) {
      SnackbarHelper.showSnackbar(
        title: "Invalid Data",
        message: "Driver or travel info is incomplete.",
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      AcceptDriverRideModel response = await acceptDriverByRiderController.acceptDriver(driverId, travelId, price);

      if (response.bidPriceInfo != null) {
        SnackbarHelper.showSnackbar(
          title: "Success",
          message: "Your trip is accepted successfully",
        );
        onSuccess(driver); // Pass data back to widget for UI update
      } else {
        SnackbarHelper.showSnackbar(
          title: "Driver Unavailable",
          message: "The driver is busy. Please choose another driver.",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      SnackbarHelper.showSnackbar(
        title: "Error",
        message: "Failed to accept trip: $e",
        backgroundColor: Colors.red,
      );
    }
  }


}
