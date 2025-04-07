import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_dashboard.dart';
import 'package:flutter/material.dart';

class Earnings extends StatefulWidget {
  const Earnings({super.key});

  @override
  State<Earnings> createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  @override
  Widget build(BuildContext context) {
    return const DriverDashboard(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Today's Earnings: \$120", style: TextStyle(fontSize: 22)),
            Text("Weekly Earnings: \$850", style: TextStyle(fontSize: 22)),
            Text("Monthly Earnings: \$3,400", style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}