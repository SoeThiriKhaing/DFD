import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaxiHome extends StatefulWidget {
  const TaxiHome({super.key});

  @override
  State<TaxiHome> createState() => _TaxiHomeState();
}

class _TaxiHomeState extends State<TaxiHome> {
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  GoogleMapController? mapController;
  LatLng? sourceLocation;
  LatLng? destinationLocation;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  String googleAPIKey = "AIzaSyAXBWwV59Q5OlaUZ1TQs-j6YXgp_7cqHPA";

  List<Map<String, dynamic>> nearbyTaxiDriver = [
    {'driverName': 'John Doe', 'carNo': 'ABC123', 'price': '10 USD'},
    {'driverName': 'Jane Smith', 'carNo': 'XYZ456', 'price': '12 USD'},
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _searchDrivers() async {
    if (sourceLocation != null) {
      final response = await http.post(
        Uri.parse('https://api.example.com/nearby-drivers'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'lat': sourceLocation!.latitude,
          'long': sourceLocation!.longitude,
          'radius': 1,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('API Response: ${response.body}');
        nearbyTaxiDriver = json.decode(response.body);
        setState(() {});
      } else {
        debugPrint('Failed to fetch drivers');
      }
    }
  }

  void _showNearbyDrivers() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nearby Taxi Drivers'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: nearbyTaxiDriver.length,
              itemBuilder: (BuildContext context, int index) {
                final driver = nearbyTaxiDriver[index];
                return ListTile(
                  title: Text(driver['driverName']),
                  subtitle: Text('Car No: ${driver['carNo']} - Price: ${driver['price']}'),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget sourceAutoComplete() {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: sourceController,
      googleAPIKey: googleAPIKey,
      inputDecoration: const InputDecoration(labelText: 'Source'),
      debounceTime: 800,
      countries: const ["MM"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (Prediction prediction) {
        setState(() {
          sourceLocation = LatLng(
            double.parse(prediction.lat!),
            double.parse(prediction.lng!),
          );
          debugPrint("Source Location: $sourceLocation");
        });
      },
      itemClick: (Prediction prediction) {
        sourceController.text = prediction.description!;
        sourceController.selection = TextSelection.fromPosition(
          TextPosition(offset: prediction.description!.length),
        );
      },
    );
  }

  Widget destinationAutoComplete() {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: destinationController,
      googleAPIKey: googleAPIKey,
      inputDecoration: const InputDecoration(labelText: 'Destination'),
      debounceTime: 800,
      countries: const ["MM"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (Prediction prediction) {
        setState(() {
          destinationLocation = LatLng(
            double.parse(prediction.lat!),
            double.parse(prediction.lng!),
          );
          debugPrint("Destination Location: $destinationLocation");
        });
      },
      itemClick: (Prediction prediction) {
        destinationController.text = prediction.description!;
        destinationController.selection = TextSelection.fromPosition(
          TextPosition(offset: prediction.description!.length),
        );
      },
    );
  }

  void _setPolylineAndMarkers() {
    if (sourceLocation != null && destinationLocation != null) {
      polylines.clear();
      markers.clear();

      polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: [sourceLocation!, destinationLocation!],
          color: Colors.blue,
          width: 5,
        ),
      );

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

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxi Booking'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: sourceAutoComplete(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: destinationAutoComplete(),
          ),
          ElevatedButton(
            onPressed: () {
              _setPolylineAndMarkers();
              // _searchDrivers().then((_) {
              //   _showNearbyDrivers();
              // });
            },
            child: const Text('Search'),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(16.8409, 96.1735),
                zoom: 14.0,
              ),
              markers: markers,
              polylines: polylines,
            ),
          ),
        ],
      ),
    );
  }
}
