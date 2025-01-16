import 'package:dailyfairdeal/screens/activities_screen.dart';
import 'package:flutter/material.dart';

class FoodActivities extends StatelessWidget {
  const FoodActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        ActivityCard(
          icon: Icons.fastfood,
          title: 'Order #12345',
          subtitle: 'Status: Out for Delivery',
          trailing: 'ETA: 20 mins',
        ),
        ActivityCard(
          icon: Icons.fastfood,
          title: 'Order #12344',
          subtitle: 'Status: Delivered',
          trailing: 'Yesterday',
        ),
      ],
    );
  }
}