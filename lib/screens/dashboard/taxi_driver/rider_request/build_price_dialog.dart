import 'package:flutter/material.dart';
import 'package:dailyfairdeal/widget/app_color.dart';

void showBidPriceDialog({
  required BuildContext context,
  required Function(double bidPrice) onSubmit,
  required int travelId,
}) {
  final TextEditingController bidPriceController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        title: const Text("Enter Your Bid Price", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Set your bid amount for this ride request.", style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 12),
            TextFormField(
              controller: bidPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.attach_money),
                hintText: "Enter bid price",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final String value = bidPriceController.text.trim();
              final double? parsedValue = double.tryParse(value);
              if (parsedValue != null) {
                onSubmit(parsedValue);
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
            child: const Text("Submit"),
          ),
        ],
      );
    },
  );
}
