import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
    
class Dashboard extends StatelessWidget {

  const Dashboard({ super.key });
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Your Dashboard',
          style: AppWidget.appBarTextStyle(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Three card views
            _buildCard('Restaurant Owner Dashboard', Colors.white, Icons.shop,
                '/restaurantownerdashboard'),
            _buildCard('Shop Owner Dashboard', Colors.white, Icons.shop,
                '/shopownerdashboard'),
            _buildCard('DFD Driver Dashboard', Colors.white,
                Icons.taxi_alert, '/driverdashboard'),
            _buildCard('DFD Rider Dashboard', Colors.white,
                Icons.car_crash, '/riderdashboard'),
          ],
        ),
      ),
    );
  }
  Widget _buildCard(String title, Color color, IconData icon, String route) {

    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                icon,
                color: AppColor.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}