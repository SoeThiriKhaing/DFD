import 'package:dailyfairdeal/screens/activities_screen.dart';
import 'package:flutter/material.dart';

class TaxiActivities extends StatelessWidget {
  const TaxiActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        ActivityCard(
          icon: Icons.local_taxi,
          title: 'Ride to Downtown',
          subtitle: 'Driver: John Doe',
          trailing: 'Ongoing',
        ),
        ActivityCard(
          icon: Icons.local_taxi,
          title: 'Ride to Airport',
          subtitle: 'Completed',
          trailing: '2 days ago',
        ),
      ],
    );
  }
}