import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaxiHome extends StatefulWidget {
  const TaxiHome({super.key});

  @override
  State<TaxiHome>  createState() => _TaxiHomeState();
}

class _TaxiHomeState extends State<TaxiHome> {
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  GoogleMapController? mapController;
  LatLng? sourceLocation;
  LatLng? destinationLocation;
  Set<Polyline> polylines = {};
  String googleAPIKey = "AIzaSyA03WIyr3gmNNOZ0AxsrwNhdwvOJ4yrOgk";

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
        // Parse and display driver data
        nearbyTaxiDriver = json.decode(response.body);
        setState(() {});
      } else {
        debugPrint('Failed to fetch drivers');
      }
    }
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
            double.parse(prediction.lat ?? "0.0"),
            double.parse(prediction.lng ?? "0.0"),
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
            double.parse(prediction.lat ?? "0.0"),
            double.parse(prediction.lng ?? "0.0"),
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

  void _setPolyline() {
    if (sourceLocation != null && destinationLocation != null) {
      polylines.clear();
      polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: [sourceLocation!, destinationLocation!],
          color: Colors.blue,
          width: 5,
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
            // child: TextField(
            //   controller: sourceController,
            //   decoration: const InputDecoration(labelText: 'Source'),
            //   onChanged: (value) {
            //     setState(() {
            //       sourceLocation = const LatLng(16.8409, 96.1735);
            //     });
            //   },
            // ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: destinationAutoComplete(),
            // child: TextField(
            //   controller: destinationController,
            //   decoration: const InputDecoration(labelText: 'Destination'),
            //   onChanged: (value) {
            //     setState(() {
            //       destinationLocation = const LatLng(16.8410, 96.1740); // Example location
            //     });
            //   },
            // ),
          ),
          ElevatedButton(
            onPressed: () {
              _setPolyline();
              _searchDrivers();
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
              polylines: polylines,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: nearbyTaxiDriver.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(nearbyTaxiDriver[index]['driverName']),
                  subtitle: Text(nearbyTaxiDriver[index]['carNo']),
                  trailing: Text(nearbyTaxiDriver[index]['price']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
