import 'package:dailyfairdeal/screens/widgets/activity_list.dart';
import 'package:flutter/material.dart';

class FoodActivities extends StatelessWidget {
  const FoodActivities({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'icon': Icons.fastfood,
        'title': 'Order #12345',
        'subtitle': 'Status: Out for Delivery',
        'trailing': 'ETA: 20 mins',
      },
      {
        'icon': Icons.fastfood,
        'title': 'Order #12344',
        'subtitle': 'Status: Delivered',
        'trailing': 'Yesterday',
      },
    ];

    return ActivityList(activities: activities);
  }
}
