import 'package:dailyfairdeal/screens/dashboard/taxi_driver/toggle_state.dart';
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

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
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