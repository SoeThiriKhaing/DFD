import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailyfairdeal/controllers/taxi/driver/bid_price_controller.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/bid_price_repository.dart';
import 'package:dailyfairdeal/services/taxi/driver/bid_price_service.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';

class DriverList extends StatelessWidget {
  final List<Map<String, String?>> driversList;
  final bool isLoading;

  // Initialize the controller
  final BidPriceController bidPriceController = Get.put(
    BidPriceController(bidPriceService: BidPriceService(bidPriceRepository: BidPriceRepository())),
  );

  DriverList({
    super.key,
    required this.driversList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 100.0,
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (driversList.isEmpty) {
      return const SizedBox(
        height: 100.0,
        child: Center(child: Text('No nearby drivers found.')),
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
              itemCount: driversList.length,
              itemBuilder: (BuildContext context, int index) {
                final driver = driversList[index];

                // Convert String? to int and double safely
                int? driverId = int.tryParse(driver['driver_id'] ?? '');
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
                            bool success = await bidPriceController.acceptDriver(driverId, travelId, price);
                            if (success) {
                              SnackbarHelper.showSnackbar(
                                title: "Success",
                                message: "Your trip is accepted successfully",
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
          title: Text(driver['driver_name'] ?? "Driver Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              onPressed: () => Navigator.pop(context),
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
