import 'dart:convert';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;

class TaxiExample extends StatefulWidget {
  const TaxiExample({super.key});

  @override
  TaxiExampleState createState() => TaxiExampleState();
}

class TaxiExampleState extends State<TaxiExample> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  TextEditingController destinationController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();
  LatLng? _currentLocation;
  bool _isLoading = false;

  static const String googleApiKey =
      "AIzaSyAx3Ou7Qb7Qg2sBnnKsvkXm6vx8Zdnkcoc"; // Replace with your API key

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Get current location of the user and convert it to an address
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _currentLocation = LatLng(position.latitude, position.longitude);

    // Convert coordinates to a human-readable address
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          currentLocationController.text =
              "${place.street}, ${place.locality}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        currentLocationController.text = "Location not available";
      });
    }
  }

  // Fetch available taxis from your backend API
  Future<void> _fetchAvailableTaxis() async {
    if (_currentLocation == null || destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please provide both locations')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String url = 'https://your-backend-api.com/getAvailableTaxis';
    final response = await http.post(Uri.parse(url), body: {
      'latitude': _currentLocation!.latitude.toString(),
      'longitude': _currentLocation!.longitude.toString(),
      'destination': destinationController.text,
    });

    if (response.statusCode == 200) {
      List<dynamic> drivers = json.decode(response.body);
      _updateTaxiMarkers(drivers);
      _drawPolyline(drivers);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to fetch taxis')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Open Google Places Autocomplete for destination input
  Future<void> _handleDestinationSearch() async {
    Prediction? prediction = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
      mode: Mode.overlay,
      language: "en",
      components: [
        Component(Component.country, "us")
      ], // Adjust country if needed
    );

    if (prediction != null) {
      destinationController.text = prediction.description!;
    }
  }

  // Update markers for available taxi drivers
  void _updateTaxiMarkers(List<dynamic> drivers) {
    setState(() {
      markers.clear();
      for (var driver in drivers) {
        markers.add(Marker(
          markerId: MarkerId(driver['id']),
          position: LatLng(driver['latitude'], driver['longitude']),
          infoWindow: InfoWindow(title: driver['name']),
        ));
      }
    });
  }

  // Draw polyline for the taxi route
  void _drawPolyline(List<dynamic> drivers) {
    List<LatLng> polylineCoordinates = [];
    for (var point in drivers) {
      polylineCoordinates.add(LatLng(point['latitude'], point['longitude']));
    }

    setState(() {
      polylines.add(Polyline(
        polylineId: PolylineId('route'),
        points: polylineCoordinates,
        color: Colors.blue,
        width: 5,
      ));
    });
  }

  // Build Google Map Widget
  Widget _buildGoogleMap() {
    if (_currentLocation == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _currentLocation!,
        zoom: 14.0,
      ),
      onMapCreated: (controller) {
        mapController = controller;
      },
      markers: markers,
      polylines: polylines,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxi Booking'),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        children: [
          // Google Map Widget
          SizedBox(
            height: 300,
            child: _buildGoogleMap(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Current location field (read-only)
                TextField(
                  controller: currentLocationController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Current Location',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.my_location),
                  ),
                ),
                const SizedBox(height: 16),
                // Destination field with Places Autocomplete
                TextField(
                  controller: destinationController,
                  readOnly: true,
                  onTap: _handleDestinationSearch,
                  decoration: const InputDecoration(
                    labelText: 'Enter Destination',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                const SizedBox(height: 16),
                // Search button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _fetchAvailableTaxis,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator())
                        : const Text(
                            'Search',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
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
