import 'package:flutter/material.dart';

class TripHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.check),
              title: Text("Trip #$index"),
              subtitle: Text("From: A \nTo: B"),
            ),
          );
        },
      ),
    );
  }
}
