import 'package:dailyfairdeal/common_calls/constant.dart';
import 'package:dailyfairdeal/config/messages.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_controller.dart';
import 'package:dailyfairdeal/screens/taxi/widgets/auto_complete_text_field.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:marquee/marquee.dart';

class TaxiHomeSearchFields extends StatelessWidget {
  final TaxiHomeController controller;
  const TaxiHomeSearchFields({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: controller.showSearchFields,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AutoCompleteTextField(
                  controller: controller.sourceController,
                  googleAPIKey: googleAPIKey,
                  labelText: 'Source',
                  onPlaceSelected: (Prediction prediction) {
                    controller.setSourceLocation(prediction);
                  },
                  prefixIcon: const Icon(Icons.my_location, color: AppColor.primaryColor),
                ),
                const SizedBox(height: 6.0),
                AutoCompleteTextField(
                  controller: controller.destinationController,
                  googleAPIKey: googleAPIKey,
                  labelText: 'Destination',
                  onPlaceSelected: (Prediction prediction) {
                    controller.setDestinationLocation(prediction);
                  },
                  prefixIcon: const Icon(Icons.location_on_sharp, color: AppColor.primaryColor),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      //onPressed: controller.isSearchButtonEnabled ? controller.clickSearchButton : null,
                       onPressed: controller.isSearchButtonEnabled ? () async {
                          if (controller.sourceLocation == null) {
                          SnackbarHelper.showSnackbar(
                            title: 'Error',
                            message: ErrorMessage.typeSource,
                            backgroundColor: Colors.red,
                          );
                          return;
                          }
                          if (controller.destinationLocation == null) {
                          SnackbarHelper.showSnackbar(
                            title: 'Error',
                            message: ErrorMessage.typeDestination,
                            backgroundColor: Colors.red,
                          );
                          return;
                          }
            
                          controller.clickSearchButton();
                          controller.startSearchingForDrivers();
                          
                        } : null,
                      child: const Text('Search', style: TextStyle(fontSize: 12.0)),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      //onPressed: controller.isCancelButtonEnabled ? () => controller.deleteTrip(0) : null,
                      onPressed: controller.isCancelButtonEnabled ? () async {
                        final confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text('Are you sure you want to cancel the trip?'),
                          actions: [
                            TextButton(
                            onPressed: () => Get.back(result: false),
                            child: const Text('No'),
                            ),
                            TextButton(
                            onPressed: () => Get.back(result: true),
                            child: const Text('Yes'),
                            ),
                          ],
                          );
                        },
                        );
            
                        if (confirm == true) {
                          controller.deleteTrip();
                        }
                      } : null,
                      child: const Text('Cancel', style: TextStyle(fontSize: 12.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (!controller.showSearchFields)
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 30.0,
                child: Marquee(
                  text: 'From: ${controller.sourceController.text.length > 20 ? '${controller.sourceController.text.substring(0, 20)}...' : controller.sourceController.text} To: ${controller.destinationController.text.length > 20 ? '${controller.destinationController.text.substring(0, 20)}...' : controller.destinationController.text}',
                  style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  scrollAxis: Axis.horizontal,
                  blankSpace: 20.0,
                  velocity: 30.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  showFadingOnlyWhenScrolling: true,
                  fadingEdgeStartFraction: 0.1,
                  fadingEdgeEndFraction: 0.1,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_downward),
                onPressed: () {

                  controller.setShowSearchFields(true);
                  
                },
              ),
            ],
          ),
      ],
    );
    
  }
}
