import 'dart:async';

import 'package:dailyfairdeal/controllers/taxi/driver/driver_location_controller.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_location_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/driver_location_repository.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/toggle_state.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_location_service.dart';
import 'package:dailyfairdeal/services/taxi/location/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class TaxiHomeScreen extends StatefulWidget {
  const TaxiHomeScreen({super.key});

  @override
  TaxiHomeScreenState createState() => TaxiHomeScreenState();
}

class TaxiHomeScreenState extends State<TaxiHomeScreen> {
  final TaxiController taxiController = Get.put(TaxiController());
  final LocationService locationService = LocationService();
  final DriverLocationController driverLocationController = DriverLocationController(
      service: DriverLocationService(repository: DriverLocationRepository()));
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
      // Update driver location every 5 seconds
    Timer.periodic(const Duration(seconds: 5), (timer) {
      updateDriverLocation();
    });
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }

  Future<void> updateDriverLocation() async {
    try {
      LatLng? currentLocation = await locationService.getCurrentLocation();

      String? driverId = await getDriverId();// Replace with dynamic ID if needed
      int taxiDriverId = int.parse(driverId!);
      bool isAvailable = taxiController.isAvailable.value; // Get online status

      // Create DriverLocation model instance
      DriverLocationModel driverLocation = DriverLocationModel(
        driverId: taxiDriverId,
        latitude: currentLocation!.latitude,
        longitude: currentLocation.longitude,
        isAvailable: isAvailable,
      );

      await driverLocationController.updateLocation(driverLocation);

      if(mounted){
         // Update the driver's location on the map
        setState(() {
          taxiController.currentPosition.value = LatLng(currentLocation.latitude, currentLocation.longitude);
        });
      } 
       
    } catch (e) {
      debugPrint("Error updating driver location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => taxiController.currentPosition.value == null
            ? const Center(
                child: Text(
                  "You are offline",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: taxiController.currentPosition.value!,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("driver"),
                    position: taxiController.currentPosition.value!,
                    infoWindow: const InfoWindow(title: "Your Location"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  taxiController.setMapController(controller);
                },
              )),

        // Toggle Button (Online/Offline)
        Positioned(
          top: 10,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Offline",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Obx(() => Switch(
                      value: taxiController.isAvailable.value,
                      onChanged: (value) =>
                          taxiController.toggleAvailability(value),
                      activeColor: Colors.green,
                    )),
                const Text("Online",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}