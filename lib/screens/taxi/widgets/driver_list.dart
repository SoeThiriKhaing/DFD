import 'package:dailyfairdeal/controllers/taxi/driver/bid_price_controller.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/bid_price_repository.dart';
import 'package:dailyfairdeal/services/taxi/driver/bid_price_service.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverList extends StatelessWidget {
  final List<Map<String, String?>> driversList;
  final bool isLoading;

  // ✅ Initialize the controller
  final BidPriceController bidPriceController = Get.put(BidPriceController(bidPriceService: BidPriceService(bidPriceRepository: BidPriceRepository())));

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

                // ✅ Convert String? to int and double safely
                int? driverId = int.tryParse(driver['driver_id'] ?? '');
                int? travelId = int.tryParse(driver['travel_id'] ?? '');
                double? price = double.tryParse(driver['price'] ?? '');

                return ListTile(
                  title: Text("Driver ID: ${driver['driver_id']}"),
                  subtitle: Text("License Plate: ${driver['license_plate']}\nPrice: ${driver['price']} MMK"),
                  trailing: ElevatedButton(
                    onPressed: (driverId != null && travelId != null && price != null)
                        ? () async {
                            bool success = await bidPriceController.acceptDriver(driverId, travelId, price);
                            if (success) {
                              SnackbarHelper.showSnackbar(
                                  title: "Success", message: "Your trip is accepted successfully");
                            //Go to the next Screen
                            } else {
                              SnackbarHelper.showSnackbar(
                                  title: "Error", message: "Failed to accept trip", backgroundColor: Colors.red);
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
}
