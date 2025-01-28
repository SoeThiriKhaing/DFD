import 'package:dailyfairdeal/widget/activity_list.dart';
import 'package:flutter/material.dart';

class MallActivities extends StatelessWidget {
  const MallActivities({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'icon': Icons.shopping_cart,
        'title': 'Shopping at Fashion Store',
        'subtitle': 'Purchase Total: \$120',
        'trailing': '1 hour ago',
      },
      {
        'icon': Icons.shopping_cart,
        'title': 'Shopping at Electronics',
        'subtitle': 'Purchase Total: \$450',
        'trailing': '3 days ago',
      },
    ];

    return ActivityList(activities: activities);
  }
}
