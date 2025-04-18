import 'package:dailyfairdeal/widget/activity_card.dart';
import 'package:flutter/material.dart';


class ActivityList extends StatelessWidget {
  final List<Map<String, dynamic>> activities;

  const ActivityList({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return ActivityCard(
          icon: activity['icon'],
          title: activity['title'],
          subtitle: activity['subtitle'],
          trailing: activity['trailing'],
        );
      },
    );
  }
}
