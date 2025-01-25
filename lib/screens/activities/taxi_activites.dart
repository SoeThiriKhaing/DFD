import 'package:dailyfairdeal/screens/widgets/activity_list.dart';
import 'package:flutter/material.dart';

class TaxiActivities extends StatelessWidget {
  const TaxiActivities({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'icon': Icons.local_taxi,
        'title': 'Ride to Downtown',
        'subtitle': 'Driver: John Doe',
        'trailing': 'Ongoing',
      },
      {
        'icon': Icons.local_taxi,
        'title': 'Ride to Airport',
        'subtitle': 'Completed',
        'trailing': '2 days ago',
      },
    ];

    return ActivityList(activities: activities);
  }
}
