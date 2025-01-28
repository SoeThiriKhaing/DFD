import 'package:flutter/material.dart';

Widget buildTextFormField(String label, TextEditingController controller, {String? Function(String?)? validator, TextInputType? keyboardType, int? maxLines}) {
  return Column(                       
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    ],
  );
}


  