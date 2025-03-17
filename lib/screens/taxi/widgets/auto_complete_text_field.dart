import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AutoCompleteTextField extends StatelessWidget {
  final TextEditingController controller;
  final String googleAPIKey;
  final String labelText;
  final Function(Prediction) onPlaceSelected;
  final Icon prefixIcon; // Add prefixIcon parameter

  const AutoCompleteTextField({
    super.key,
    required this.controller,
    required this.googleAPIKey,
    required this.labelText,
    required this.onPlaceSelected,
    required this.prefixIcon, // Initialize prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: googleAPIKey,
          inputDecoration: InputDecoration(
            hintText: labelText,
            prefixIcon: prefixIcon, // Use prefixIcon if provided
            fillColor: Colors.grey[200],
            labelStyle: const TextStyle(fontSize: 14.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          ),
          debounceTime: 800,
          countries: const ["MM"],
          isLatLngRequired: true,
          showError: true,
          getPlaceDetailWithLatLng: onPlaceSelected,
          itemClick: (Prediction prediction) {
            controller.text = prediction.description!;
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length),
            );
          },
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
            },
          ),
        ),
      ],
    );
  }
}