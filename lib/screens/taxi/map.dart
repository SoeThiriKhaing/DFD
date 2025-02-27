
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  TextEditingController destinationController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();

  LatLng? _currentLocation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Get current location of the user
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      currentLocationController.text =
          '${position.latitude}, ${position.longitude}';
    });
  }

  // Fetch available taxis (fake data for now)
  Future<void> _fetchAvailableTaxis() async {
    setState(() {
      _isLoading = true;
    });

    // Simulating fake taxi data
    await Future.delayed(const Duration(seconds: 2));

    List<dynamic> drivers = [
      {
        'id': '1',
        'name': 'Taxi 1',
        'latitude': 37.7749,
        'longitude': -122.4194
      },
      {
        'id': '2',
        'name': 'Taxi 2',
        'latitude': 37.7750,
        'longitude': -122.4184
      },
      {
        'id': '3',
        'name': 'Taxi 3',
        'latitude': 37.7751,
        'longitude': -122.4174
      },
    ];

    _updateTaxiMarkers(drivers);
    _drawPolyline(drivers);

    setState(() {
      _isLoading = false;
    });
  }

  // Update markers for the available taxi drivers
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

  // Draw polyline between current location and the drivers
  void _drawPolyline(List<dynamic> drivers) {
    List<LatLng> polylineCoordinates = [];
    for (var point in drivers) {
      polylineCoordinates.add(LatLng(point['latitude'], point['longitude']));
    }

    setState(() {
      polylines.add(Polyline(
        polylineId: const PolylineId('route'),
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
          // Google Map Widget at the top
          Container(
            height: 300,
            child: _buildGoogleMap(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Current location field
                TextField(
                  controller: currentLocationController,
                  readOnly: false, // Allow user to edit the location
                  decoration: const InputDecoration(
                    labelText: 'Current Location (lat, lng)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // City name field

                // Destination field
                TextField(
                  controller: destinationController,
                  decoration: const InputDecoration(
                    labelText: 'Enter destination',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Search button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                            child: CircularProgressIndicator(),
                          )
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
