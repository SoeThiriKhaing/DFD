import 'package:flutter/material.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/widget/app_color.dart';

class RideRequestCard extends StatelessWidget {
  final TravelModel request;
  final Function(int travelId) onSubmitBid;

  const RideRequestCard({
    super.key,
    required this.request,
    required this.onSubmitBid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(request.user?.name ?? 'Unknown Rider', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _infoRow(Icons.location_on, "Pickup: ${request.pickupAddress ?? 'Fetching...'}", Colors.green),
            const SizedBox(height: 6),
            _infoRow(Icons.flag, "Dropoff: ${request.destinationAddress ?? 'Fetching...'}", Colors.red),
            const SizedBox(height: 6),
            _infoRow(Icons.phone, "Phone: ${request.user?.phone ?? 'N/A'}", Colors.teal),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton(context, Icons.call, "Call", Colors.teal, () {}),
                _actionButton(context, Icons.message, "Text", Colors.orange, () {}),
                _actionButton(context, Icons.attach_money, "Price", AppColor.primaryColor, () {
                  onSubmitBid(request.travelId!);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      onPressed: onPressed,
    );
  }
}
