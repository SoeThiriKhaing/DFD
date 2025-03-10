import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TaxiHomeScreen extends StatefulWidget {
  const TaxiHomeScreen({super.key});

  @override
  TaxiHomeScreenState createState() => TaxiHomeScreenState();
}

class TaxiHomeScreenState extends State<TaxiHomeScreen> {
  bool isAvailable = false;
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  // Check & Request Location Permission
  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }

  // Get Driver's Current Location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _mapController
            ?.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Google Map
        _currentPosition == null
            ? const Center(
                child: Text(
                  "You are offline",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentPosition!,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("driver"),
                    position: _currentPosition!,
                    infoWindow: const InfoWindow(title: "Your Location"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              ),

        // Toggle Button (On/Off)
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
                Switch(
                  value: isAvailable,
                  onChanged: (value) {
                    setState(() {
                      isAvailable = value;
                      if (isAvailable) {
                        _getCurrentLocation();
                      } else {
                        _currentPosition = null; // Hide location when offline
                      }
                    });
                  },
                  activeColor: Colors.green,
                ),
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
