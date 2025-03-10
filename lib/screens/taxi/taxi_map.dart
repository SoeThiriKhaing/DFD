import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:location/location.dart';

class TaxiMap extends StatefulWidget {
  const TaxiMap({super.key});

  @override
  State<TaxiMap> createState() => _TaxiMapState();
}

class _TaxiMapState extends State<TaxiMap> {
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  GoogleMapController? mapController;
  LatLng? sourceLocation;
  LatLng? destinationLocation;
  Location location = Location();
  LatLng? currentLocation;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  String googleAPIKey = "AIzaSyAXBWwV59Q5OlaUZ1TQs-j6YXgp_7cqHPA";
  bool isLoading = false;
  bool showDriverList = false;
  bool showSearchFields = true;
  List<Map<String, dynamic>> nearbyTaxiDriver = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((_) {
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
    });
  }

  Future<void> _getCurrentLocation() async {
    final locData = await location.getLocation();
    setState(() {
      currentLocation = LatLng(locData.latitude!, locData.longitude!);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _moveToCurrentLocation() {
    if (currentLocation != null) {
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLocation!, zoom: 14.0),
        ),
      );
    }
  }

  Widget _buildAutoCompleteField({
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required Function(Prediction) onPlaceSelected,
  }) {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller,
      googleAPIKey: googleAPIKey, // Replace with your API key
      inputDecoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColor.primaryColor),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
      debounceTime: 800,
      countries: const ["MM"], // Limit to specific countries if needed
      isLatLngRequired: true,
      showError: true,
      getPlaceDetailWithLatLng: (Prediction prediction) {
        onPlaceSelected(prediction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taxi Booking",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                _buildAutoCompleteField(
                  hint: "Enter Pickup Location",
                  controller: sourceController,
                  icon: Icons.my_location,
                  onPlaceSelected: (Prediction prediction) {
                    setState(() {
                      sourceLocation = LatLng(
                        double.parse(prediction.lat!),
                        double.parse(prediction.lng!),
                      );
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildAutoCompleteField(
                  hint: "Enter Destination",
                  controller: destinationController,
                  icon: Icons.location_on,
                  onPlaceSelected: (Prediction prediction) {
                    setState(() {
                      destinationLocation = LatLng(
                        double.parse(prediction.lat!),
                        double.parse(prediction.lng!),
                      );
                    });
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Find route logic
                    },
                    child: const Text(
                      "Find Route",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: currentLocation ?? const LatLng(37.7749, -122.4194),
                zoom: 12.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: _moveToCurrentLocation,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}
