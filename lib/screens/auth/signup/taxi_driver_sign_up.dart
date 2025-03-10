import 'dart:convert';
import 'package:dailyfairdeal/widget/phone_text_field_widget.dart';
import 'package:dailyfairdeal/widget/reusabel_button.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:dailyfairdeal/widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class TaxiDriverSignUp extends StatefulWidget {
  const TaxiDriverSignUp({super.key});

  @override
  State<TaxiDriverSignUp> createState() => _TaxiDriverSignUpState();
}

class _TaxiDriverSignUpState extends State<TaxiDriverSignUp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  // Additional required fields
  //final TextEditingController latitudeController = TextEditingController();
  //final TextEditingController longitudeController = TextEditingController();
  bool isAvailable = true;
  final TextEditingController carYearController = TextEditingController();
  final TextEditingController carMakeController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carColourController = TextEditingController();
  final TextEditingController licensePlateController = TextEditingController();
  final TextEditingController driverLicenseNumberController =
      TextEditingController();
  final TextEditingController otherInfoController = TextEditingController();

  Widget buildDateOfBirthTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date of Birth",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: dobController,
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'yyyy-MM-dd',
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                await selectDateOfBirth(context);
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your date of birth';
            }
            return null;
          },
        ),
      ],
    );
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> requestBody = {
        // "latitude": double.tryParse(latitudeController.text) ?? 0.0,
        // "longitude": double.tryParse(longitudeController.text) ?? 0.0,
        "is_available": isAvailable,
        "car_year": int.tryParse(carYearController.text) ?? 2020,
        "car_make": carMakeController.text,
        "car_model": carModelController.text,
        "car_colour": carColourController.text,
        "license_plate": licensePlateController.text,
        "driver_license_number": driverLicenseNumberController.text,
        "other_info": otherInfoController.text,
      };

      try {
        final response = await http.post(
          Uri.parse("http://api.dailyfairdeal.com/api/taxi-drivers"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          SnackbarHelper.showSnackbar(
            title: "Success",
            message: "Taxi driver registered successfully!",
            backgroundColor: Colors.green,
          );
          Get.offNamed('/driverdashboard');
        } else {
          SnackbarHelper.showSnackbar(
            title: "Error",
            message: "Failed to register. Please try again.",
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: "Something went wrong: $e",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Widget buildSubmitButton() {
    return ReusableButton(
      text: "Submit",
      onPressed: submitForm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ready to hit the road?',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Fill out the form below',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextFormField('Name', nameController,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                buildTextFormField('Email', emailController,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 10),
                buildPhoneField(phoneController),
                const SizedBox(height: 10),
                buildDateOfBirthTextFormField(),
                const SizedBox(height: 10),
                buildTextFormField('Address', addressController,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                buildTextFormField('Referral Code', referralCodeController,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 20),
                // buildTextFormField('Latitude', latitudeController,
                // keyboardType: TextInputType.number),
                //const SizedBox(height: 10),
                //buildTextFormField('Longitude', longitudeController,
                //    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                buildTextFormField('Car Year', carYearController,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                buildTextFormField('Car Make', carMakeController),
                const SizedBox(height: 10),
                buildTextFormField('Car Model', carModelController),
                const SizedBox(height: 10),
                buildTextFormField('Car Colour', carColourController),
                const SizedBox(height: 10),
                buildTextFormField('License Plate', licensePlateController),
                const SizedBox(height: 10),
                buildTextFormField(
                    'Driver License Number', driverLicenseNumberController),
                const SizedBox(height: 10),
                buildTextFormField('Other Info', otherInfoController),
                const SizedBox(height: 20),
                buildSubmitButton(),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
