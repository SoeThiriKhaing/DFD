import 'dart:async';
import 'dart:convert';
import 'package:dailyfairdeal/common_calls/constant.dart';
import 'package:dailyfairdeal/controllers/auth/auth_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/driver/accept_driver_rider_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/driver/driver_location_controller.dart';
import 'package:dailyfairdeal/controllers/taxi/travel/travel_controller.dart';
import 'package:dailyfairdeal/main.dart';
import 'package:dailyfairdeal/models/taxi/driver/accept_driver_ride_model.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_location_model.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/repositories/auth/auth_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/accept_driver_ride_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/driver_location_repository.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/get_address_from_latlong.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_dashboard.dart';
import 'package:dailyfairdeal/services/auth/auth_service.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/services/taxi/driver/accept_driver_ride_service.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_location_service.dart';
import 'package:dailyfairdeal/services/taxi/location/location_service.dart';
import 'package:dailyfairdeal/services/taxi/travel/travel_service.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class TaxiHomeScreen extends StatefulWidget {
  const TaxiHomeScreen({super.key});

  @override
  TaxiHomeScreenState createState() => TaxiHomeScreenState();
}

class TaxiHomeScreenState extends State<TaxiHomeScreen> {
  final LocationService locationService = LocationService();
  final DriverLocationController driverLocationController = DriverLocationController(
      service: DriverLocationService(repository: DriverLocationRepository()));
  final TravelController travelController = Get.put(TravelController(
      travelService: TravelService(travelRepository: TravelRepository())));
  final AcceptDriverRideController acceptDriverRiderController = Get.put(AcceptDriverRideController(service: AcceptDriverRideService(repository: AcceptDriverRideRepository())));
  final AuthController authController = Get.put(AuthController(authService: AuthService(authRepository: AuthRepository())));
  int? taxiDriverId;
  Timer? _timer;
  LatLng? sourceLocation;
  LatLng? destinationLocation;
  LatLng? driverLocation;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  LatLng? currentLocation;
  GoogleMapController? mapController;
  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);
  Set<int> notifiedTravelAcceptIds = <int>{};
  bool showUserList = false;
  bool isLoading = false;
  List<Map<String, String?>> userInfoList = [];
  int? riderId;
  int? travelId;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    getCurrentLocation();
    _getDriverId();
    _loadNotifiedTravelIds();
    _initialize();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      updateDriverLocation();
    });
  }

  Future<void> _loadNotifiedTravelIds() async {
    notifiedTravelAcceptIds = await getNotifiedTravelIds();
  }

  Future<void> getRiderInfo(int riderId) async{
    List<Map<String, String?>> userList= await authController.getUserInfoById(riderId);
    userInfoList = userList;
  }

  Future<void> getCurrentLocation() async {
    try {
      LatLng? position = await locationService.getCurrentLocation();
      currentPosition.value = position;
      mapController?.animateCamera(CameraUpdate.newLatLng(position!));
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  Future<void> _getDriverId() async {
    String? driverId = await getDriverId();
    taxiDriverId = int.parse(driverId!);
  }

  Future<void> updateDriverLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentLocation = LatLng(position.latitude, position.longitude);
      if (taxiDriverId == null) return;

      DriverLocationModel driverLocation = DriverLocationModel(
        driverId: taxiDriverId!,
        latitude: currentLocation!.latitude,
        longitude: currentLocation!.longitude,
        isAvailable: true,
      );

      int statusCode = await driverLocationController.updateLocation(driverLocation);
      if (statusCode == 200) {
        setState(() {
          currentPosition.value = currentLocation;
        });
      }
    } catch (e) {
      debugPrint("Exception updating driver location: $e");
    }
  }

  Future<void> fetchRideDetails(int travelId) async {
    try {
      debugPrint("Fetching ride details for Travel ID: $travelId");
      // Fetch ride details from API
      AcceptDriverRideModel request = await acceptDriverRiderController.acceptRideByDriver(travelId);

      debugPrint("Ride Details Response: $request");

      if (request.travelData == null) {
        debugPrint("No travel data found!");
        return;
      }

      riderId = request.bidPriceInfo!.userId; //Store rider id to the global variable
      if(riderId != null){
        await getRiderInfo(riderId!);
      }

      // Convert LatLng to Address
      String pickupAddress = await getAddressFromLatLng(
        request.travelData!.pickupLatitude,
        request.travelData!.pickupLongitude,
      );
      String destinationAddress = await getAddressFromLatLng(
        request.travelData!.destinationLatitude,
        request.travelData!.destinationLongitude,
      );

      // Extract locations
      sourceLocation = LatLng(
        request.travelData!.pickupLatitude,
        request.travelData!.pickupLongitude,
      );
      destinationLocation = LatLng(
        request.travelData!.destinationLatitude,
        request.travelData!.destinationLongitude,
      );

      if (currentPosition.value == null) {
        debugPrint("Error: currentPosition is null.");
        return;
      }
      driverLocation = currentPosition.value!;

      if(mounted){
        setState(() {
          markers.addAll ([
            Marker(
              markerId: const MarkerId("driver"),
              position: driverLocation!,
              infoWindow: const InfoWindow(title: "Your Location"),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            ),
            Marker(
              markerId: const MarkerId("pickup"),
              position: sourceLocation!,
              infoWindow: InfoWindow(title: "Pickup: $pickupAddress"),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            ),
            Marker(
              markerId: const MarkerId("destination"),
              position: destinationLocation!,
              infoWindow: InfoWindow(title: "Destination: $destinationAddress"),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          ]);
        });
    
      } else {
        debugPrint("Widget is not mounted, skipping setState.");
      }

      if (mapController != null) {
        // Adjust camera to show all markers
        await mapController?.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                [driverLocation!.latitude, sourceLocation!.latitude, destinationLocation!.latitude].reduce((a, b) => a < b ? a : b),
                [driverLocation!.longitude, sourceLocation!.longitude, destinationLocation!.longitude].reduce((a, b) => a < b ? a : b),
              ),
              northeast: LatLng(
                [driverLocation!.latitude, sourceLocation!.latitude, destinationLocation!.latitude].reduce((a, b) => a > b ? a : b),
                [driverLocation!.longitude, sourceLocation!.longitude, destinationLocation!.longitude].reduce((a, b) => a > b ? a : b),
              ),
            ),
            100,
          ),
        );

        showUserList = true;

      } else {
        debugPrint("Error: mapController is null.");
      }  

      await getRoute(polylineColor: Colors.green);

    } catch (e) {
      debugPrint("Error fetching ride details: $e");
    }
  }

  Future<void> _initialize() async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        fetchRideAccepted(); // Fetch rider accepted every 5 seconds
      } else {
        timer.cancel(); // Stop timer if the screen is no longer mounted
      }
    });
  }

  //To fetch rider accepted and rejected requests
  Future<void> fetchRideAccepted() async{
    try{

      if (!mounted) return;

      List<TravelModel> requests = await travelController.fetchRiderAccepted(taxiDriverId!);

      if (mounted) {
        for (var request in requests) {
          travelId = request.travelId!; //Save travelId to the global variable
          // Check if the travelId is already notified
          String userName = request.user!.name;
          String pickupLocation = await getAddressFromLatLng(request.pickupLatitude, request.pickupLongitude);
          String destinationLocation = await getAddressFromLatLng(request.destinationLatitude, request.destinationLongitude);
          
          // Show notification only if the travelId has not been notified already
          if (!notifiedTravelAcceptIds.contains(travelId)) {
            showRideAcceptPopup(userName, pickupLocation, destinationLocation, travelId!);
            notifiedTravelAcceptIds.add(travelId!); // Mark as notified

            //Save to the secure storage
            await saveNotifiedTravelIds(notifiedTravelAcceptIds);
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching ride accepted: $e");
    }
  }
  
  void showRideAcceptPopup(String userName, String pickup, String destination, int travelId) {
    if (Get.currentRoute != "/taxi_driver_home") {
      debugPrint("Popup skipped: Not on home screen");
      return; // Prevent dialog if not on TaxiHomeScreen
    }
    showDialog(
      context: navigatorKey.currentContext!,  // Ensure you have a GlobalKey<NavigatorState> set for navigation
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("New Ride Accepted"),
          content: Text("Rider: $userName\nPickup: $pickup\nDestination: $destination."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text("Dismiss"),
            ),
            TextButton(
                onPressed: () async {
                Get.back(); // Close the dialog
                setState(() {
                  isLoading = true; // Show loading indicator
                  showUserList = true; // Show user list
                });
                await Future.delayed(const Duration(seconds: 3), () {
                  setState(() {
                  isLoading = false; // Hide loading indicator after delay
                  showUserList = false;
                  });
                });
                await fetchRideDetails(travelId);
                setState(() {
                  isLoading = false; // Hide loading indicator
                });
                },
              child: const Text("Accept"),
            ),
          ],
        );
      },
    );
  }

  void handleRideAccept(int travelId) {
    debugPrint("Ride with ID $travelId accepted.");
    // Add logic to update UI or backend when ride is accepted
    fetchRideDetails(travelId);

  }
  
  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }


  @override
  void dispose() {
    // Cancel the timer when the screen is disposed (when navigating back)
    _timer?.cancel();

    super.dispose();
  }

  Future<void> getRoute({required Color polylineColor}) async {
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

  @override
  Widget build(BuildContext context) {
    return DriverDashboard(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Obx(() => currentPosition.value == null
                    ? const Center(
                        child: Text("You are offline", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      )
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(target: currentPosition.value!, zoom: 15),
                        markers: markers,
                        polylines: polylines,
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                      )),
              
              ],
            ),
          ),
          if (showUserList)...[
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : 
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
              children: [
                const Text(
                "User Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...userInfoList.map((user) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                    Icons.person,
                    color: Colors.white,
                    ),
                  ),
                  title: Text(user['name'] ?? 'Unknown'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Email: ${user['email']}"),
                    Text("Phone: ${user['phone'] ?? 'N/A'}"),
                    ],
                  ),
                  ),
                );
                }),
                isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                    isLoading = true; // Show loading indicator while waiting for driver response
                    });
                    bool statusTravelComplete = await travelController.travelComplete(travelId!);
                    if (statusTravelComplete) {
                    debugPrint("Travel completed successfully");
                    SnackbarHelper.showSnackbar(
                      title: "Success",
                      message: "The trip is completed successfully. You are available for the next trip.",
                    );
                    setState(() {
                      showUserList = false;
                      isLoading = false;
                      polylines.clear();
                      markers.clear();
                      sourceLocation = null;
                      destinationLocation = null;
                      driverLocation = null;
                      currentPosition.value = null;
                      travelId = null;
                      riderId = null;
                      userInfoList.clear();
                    });
                    } else {
                    debugPrint("Failed to complete travel");
                    setState(() {
                      isLoading = false;
                    });
                    }
                  },
                  child: const Text("Complete Trip"),
                  ),
              ],
              ),
            ),
            
          ]
        ],
      ),
    );
  }
}
