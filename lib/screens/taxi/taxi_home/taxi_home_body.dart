import 'package:dailyfairdeal/screens/taxi/taxi_home/nearby_taxi_driver_list_widget.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_controller.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_map.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_search_field.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/selected_driver_info_card.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TaxiHomeBody extends StatelessWidget {
  const TaxiHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaxiHomeController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            // Search Fields
            TaxiHomeSearchFields(controller: controller),

            // Map Placeholder (replace with actual GoogleMap widget)
            TaxiHomeMap(controller: controller),

            // After search the trip, if there are nearby taxi drivers, show Nearby Taxi Driver List with bidding price
            if (controller.showDriverList) ...[
              if (controller.nearbyDrivers.isNotEmpty) ...[
                Expanded(
                  child: NearbyTaxiDriverListWidget(
                    driversList: controller.nearbyTaxiDriver,
                    isLoading: controller.isLoading,
                    onDriverAccepted: (driver) {
                      controller.setLoadingStatus(true);

                      // Simulate waiting for driver response
                      Future.delayed(const Duration(seconds: 3), () {
                        controller.setLoadingStatus(false);
                        // If the driver accepts, update polyline and marker
                        controller.updatePolylineAndMarker(driver);
                        controller.travelId = int.tryParse(driver['travel_id'] ?? '');
                        controller.checkCompleteTrip(controller.travelId!);
                      });
                    },
                  ),
                ),
              ] else ...[
                const SizedBox(
                  height: 100.0,
                  child: Center(child: Text('No nearby drivers found.')),
                ),
              ],
            ],

            // To Show Selected Driver Info List & Complete Trip Button
            if (controller.showSelectedDriverInfo)
              SelectedDriverInfoCard(
                driverInfo: controller.selectedDriverInfo,
                showCompleteTrip: controller.showCompleteTrip,
                onCompleteTrip: () {
                  controller.setCompleteTrip();
                  SnackbarHelper.showSnackbar(
                    title: 'Trip Completed',
                    message: 'Thank you for using our service!',
                    backgroundColor: Colors.green,
                  );
                  Get.offNamed('/taxi_home_screen');
                },
              )
          ],
        );
      },
    );
  }
}
