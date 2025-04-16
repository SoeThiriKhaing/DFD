import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_controller.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/build_nearby_taxi_driver_info_row_widget.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class NearbyTaxiDriverCard extends StatelessWidget {
  final Map<String, String?> driver;
  final void Function(Map<String, String?> driver) onAccept;

  const NearbyTaxiDriverCard({
    super.key,
    required this.driver,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TaxiHomeController>(context, listen: false);
    // Convert String? to int and double safely
    int? driverId = int.tryParse(driver['taxi_driver_id'] ?? '');
    int? travelId = int.tryParse(driver['travel_id'] ?? '');
    double? price = double.tryParse(driver['price'] ?? '');

    return Card(
      elevation: 5.0,
      color: Colors.white,
      child: ListTile(
        title: GestureDetector(
          onTap: () => _showDriverDetails(context),
          child: Row(
            children: [
              const Icon(
                Icons.person,
                color: AppColor.primaryColor,
              ),
              Text(
                " ${driver['driver_name']}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 40.0,
              )
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.car_crash,
                  size: 20,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  "${driver['license_plate']}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.attach_money,
                  size: 20,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  "${driver['price']} MMK",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
          onPressed: () {
            controller.stopSearchingForDrivers();
            controller.handleDriverAcceptance(
              driverId,
              travelId,
              price,
              driver,
              onAccept,
            );
          },
          child: const Text(
            "Book",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  void _showDriverDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Driver Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildNearByTaxiDriverInfoRow("Name", driver['driver_name']),
            buildNearByTaxiDriverInfoRow("Age", driver['driver_age']),
            buildNearByTaxiDriverInfoRow("Phone", driver['driver_phone']),
            buildNearByTaxiDriverInfoRow("Email", driver['driver_email']),
            buildNearByTaxiDriverInfoRow(
                "License Plate", driver['license_plate']),
            buildNearByTaxiDriverInfoRow("Car Make", driver['car_make']),
            buildNearByTaxiDriverInfoRow("Car Model", driver['car_model']),
            buildNearByTaxiDriverInfoRow("Color", driver['car_color']),
            buildNearByTaxiDriverInfoRow("Year", driver['car_year']),
            buildNearByTaxiDriverInfoRow("Other Info", driver['other_info']),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Close")),
        ],
      ),
    );
  }
}
