import 'package:flutter/material.dart';

class EarningsSummaryScreen extends StatelessWidget {
  const EarningsSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
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