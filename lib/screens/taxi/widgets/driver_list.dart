import 'dart:async';
import 'package:dailyfairdeal/controllers/taxi/driver/accept_driver_rider_controller.dart';
import 'package:dailyfairdeal/models/taxi/driver/accept_driver_ride_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/accept_driver_ride_repository.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home.dart';
import 'package:dailyfairdeal/services/taxi/driver/accept_driver_ride_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';

class DriverList extends StatefulWidget {
  final List<Map<String, String?>> driversList;
  final bool isLoading;
  final Function(Map<String, String?> driver) onDriverAccepted;

  const DriverList({
    super.key,
    required this.driversList,
    required this.isLoading,
    required this.onDriverAccepted,
  });

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  final AcceptDriverRideController acceptDriverByRiderController = Get.put(
    AcceptDriverRideController(service: AcceptDriverRideService(repository: AcceptDriverRideRepository())),
  );

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        Get.find<TaxiHomeState>().fetchNearByTaxiDrivers();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const SizedBox(
        height: 100.0,
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (widget.driversList.isEmpty) {
      return const SizedBox(
        height: 100.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Please Wait to Nearby Taxi Driver Response....'),
            ],
          ),
        ),
      );
    } else {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Nearby Taxi Drivers',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.driversList.length,
              itemBuilder: (BuildContext context, int index) {
                final driver = widget.driversList[index];

                // Convert String? to int and double safely
                int? driverId = int.tryParse(driver['taxi_driver_id'] ?? '');
                int? travelId = int.tryParse(driver['travel_id'] ?? '');
                double? price = double.tryParse(driver['price'] ?? '');

                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      _showDriverDetails(context, driver);
                    },
                    child: Text(
                      "Driver Name: ${driver['driver_name']}",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Make it look like a clickable link
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  subtitle: Text("License Plate: ${driver['license_plate']}\nPrice: ${driver['price']} MMK"),
                  trailing: ElevatedButton(
                    onPressed: (driverId != null && travelId != null && price != null)
                        ? () async {
                            AcceptDriverRideModel response = await acceptDriverByRiderController.acceptDriver(driverId, travelId, price);
                            if (response.bidPriceInfo != null) {
                              SnackbarHelper.showSnackbar(
                                title: "Success",
                                message: "Your trip is accepted successfully",
                              );
                              // Hide driver list and mark locations on the map
                              widget.onDriverAccepted(driver);
                            } else if (response.bidPriceInfo == null){
                              SnackbarHelper.showSnackbar(
                                title: "Driver Unavailable",
                                message: "The driver is busy and has already taken another trip. Please choose another driver.",
                                backgroundColor: Colors.red,
                              );
                            } else {
                              SnackbarHelper.showSnackbar(
                                title: "Error",
                                message: "Failed to accept trip",
                                backgroundColor: Colors.red,
                              );
                            }
                          }
                        : null, // Disable button if values are invalid
                    child: const Text('Accept'),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  void _showDriverDetails(BuildContext context, Map<String, String?> driver) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Driver Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDriverInfoRow("Name", driver['driver_name']),
              _buildDriverInfoRow("Age", driver['driver_age']),
              _buildDriverInfoRow("Phone", driver['driver_phone']),
              _buildDriverInfoRow("Email", driver['driver_email']),
              _buildDriverInfoRow("License Plate", driver['license_plate']),
              _buildDriverInfoRow("Car Make", driver['car_make']),
              _buildDriverInfoRow("Car Model", driver['car_model']),
              _buildDriverInfoRow("Car Colour", driver['car_colour']),
              _buildDriverInfoRow("Car Year", driver['car_year']),
              _buildDriverInfoRow("Other Info", driver['other_info']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDriverInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
