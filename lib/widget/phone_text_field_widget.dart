import 'package:dailyfairdeal/widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

Widget buildPhoneField(TextEditingController phoneController) {
    return buildTextFormField(
      'Phone Number',
      phoneController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the phone number';
        } else if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
          return 'Enter a valid phone number';
        }
        return null;
      },
      keyboardType: TextInputType.phone,  // Use phone keyboard
    );
  }