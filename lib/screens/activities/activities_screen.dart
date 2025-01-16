import 'package:dailyfairdeal/screens/activities/food_activities.dart';
import 'package:dailyfairdeal/screens/activities/mall_activities.dart';
import 'package:dailyfairdeal/screens/activities/taxi_activites.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.primaryColor, // Updated color
          title: Text('Activities', style: AppWidget.appBarTextStyle()),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.fastfood, size: 24),
                text: 'Food',
              ),
              Tab(
                icon: Icon(Icons.local_taxi, size: 24),
                text: 'Taxi',
              ),
              Tab(
                icon: Icon(Icons.store, size: 24),
                text: 'Mall',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FoodActivities(),
            TaxiActivities(),
            MallActivities(),
          ],
        ),
      ),
    );
  }
}