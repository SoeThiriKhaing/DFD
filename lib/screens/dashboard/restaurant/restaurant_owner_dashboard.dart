import 'package:dailyfairdeal/screens/dashboard/drawer/restaurant_owner_drawer.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';

class RestaurantOwnerDashboard extends StatelessWidget {
  const RestaurantOwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Owner Dashboard', style: AppWidget.subTitle()),
        backgroundColor: AppColor.primaryColor,
      ),
      drawer: const RestaurantOwnerDrawer(), // Reusable drawer
      body: const Center(
        child: Text(
          'Welcome to the Restaurant Owner Dashboard!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
