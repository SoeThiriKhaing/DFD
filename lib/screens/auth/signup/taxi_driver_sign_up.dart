import 'dart:convert';
import 'package:dailyfairdeal/controllers/taxi/driver/driver_controller.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/driver_repository.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_service.dart';
import 'package:dailyfairdeal/services/taxi/location/location_service.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaxiDriverSignUp extends StatefulWidget {
  const TaxiDriverSignUp({super.key});

  @override
  State<TaxiDriverSignUp> createState() => _TaxiDriverSignUpState();
}

class _TaxiDriverSignUpState extends State<TaxiDriverSignUp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController carYearController = TextEditingController();
  final TextEditingController carMakeController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carColorController = TextEditingController();
  final TextEditingController licensePlateController = TextEditingController();

  final TextEditingController otherInfoController = TextEditingController();
  final DriverController driverController = Get.put(DriverController(
      service: DriverService(repository: DriverRepository())));

  void handleSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        // Get username and userId from secure storage
        String? userName = await getUserName();
        String? userId = await getUserId();

        if (userName == null || userId == null) {
          SnackbarHelper.showSnackbar(
              title: "Error",
              message: "Information is missing. Please Login again.");
          return;
        }

        bool isDriverExists = await driverController.isDriverAlreadyRegistered(int.parse(userId));
        debugPrint("Is Driver Exist? : $isDriverExists");
        if (isDriverExists) {
          SnackbarHelper.showSnackbar(
              title: "Error",
              message: "You have already created a driver account with this email.",
              backgroundColor: Colors.red
            );
          return;
        }

        // Get current position
        LatLng? position = await LocationService().getCurrentLocation();
        if (position == null) {
          SnackbarHelper.showSnackbar(
              title: "Error",
              message: "Unable to get current location.");
          return;
        }

        // Create DriverModel object with gathered data
        final driver = DriverModel(
          userId: int.tryParse(userId) ?? 0,
          name: userName,
          latitude: position.latitude,
          longitude: position.longitude,
          isAvailable: true,
          carYear: int.tryParse(carYearController.text) ?? 0,
          carMake: carMakeController.text,
          carModel: carModelController.text,
          carColour: carColorController.text,
          licensePlate: licensePlateController.text,
          otherInfo: otherInfoController.text,
        );

        // Log the driver JSON payload
        debugPrint('🚗 Driver JSON payload: ${jsonEncode(driver.toJson())}');

        // Call the method to save the driver data in backend
        await driverController.createDriver(driver);

        // ✅ Navigate to dashboard if mounted
        if (mounted) {
          Get.offNamed('/driverdashboard');
        }
      } catch (e) {
        debugPrint('❌ Error during request: $e');

        // ✅ Show error message if mounted
        if (mounted) {
          SnackbarHelper.showSnackbar(title: "Error", backgroundColor: Colors.red, message: 'An error occurred: $e');
        }
      }
    }
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          validator: (value) => value!.isEmpty ? 'Required field' : null,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Driver Info")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTextField("Car Year", carYearController,
                    keyboardType: TextInputType.number),
                buildTextField("Car Make", carMakeController),
                buildTextField("Car Model", carModelController),
                buildTextField("Car Colour", carColorController),
                buildTextField("License Plate", licensePlateController),
                buildTextField("Other Info", otherInfoController),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor),
                    onPressed: () {
                      handleSubmit();
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}