import 'package:dailyfairdeal/widget/phone_text_field_widget.dart';
import 'package:dailyfairdeal/widget/reusabel_button.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:dailyfairdeal/widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
    
class RiderSignUp extends StatefulWidget {
  const RiderSignUp({super.key});

  @override
  State<RiderSignUp> createState() => _RiderSignUpState();
}

class _RiderSignUpState extends State<RiderSignUp> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

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

  Widget buildSubmitButton() {
    return ReusableButton(
      text: "Submit",
      onPressed: () {
        if (formKey.currentState!.validate()) {
          SnackbarHelper.showSnackbar(
            title: "Success",
            message: "The data has been saved",
            backgroundColor: Colors.green,
          );
        }
      },
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
                buildTextFormField('Name', nameController, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                buildTextFormField('Email', emailController, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 10),
                buildPhoneField(phoneController),
                const SizedBox(height: 10),
                buildDateOfBirthTextFormField(),
                const SizedBox(height: 10),
                buildTextFormField('Address', addressController, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                buildTextFormField('Referral Code', referralCodeController, keyboardType: TextInputType.text),
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