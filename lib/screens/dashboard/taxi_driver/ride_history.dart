import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_dashboard.dart';
import 'package:flutter/material.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  @override
  Widget build(BuildContext context) {
    return DriverDashboard(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.check),
              title: Text("Trip #$index"),
              subtitle: const Text("From: A \nTo: B"),
            ),
          );
        },
      ),
    );
  }
}