 import 'package:flutter/material.dart';

Widget buildDropdownField(String label, String? value, List<Map<String, String>> items, Function(String?) onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select Value',
          ),
          items: items.isEmpty ?
            [
              const DropdownMenuItem(
                enabled: false,
                value: "No option availabel",
                child: Text('No option available'),
              ),
            ]:
          items.map((type) {
            return DropdownMenuItem<String>(
              value: type['name'],
              child: Text(
                type['name']!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $label';
            }
            return null;
          },
        ),
      ],
    );
  }