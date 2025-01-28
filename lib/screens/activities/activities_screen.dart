import 'package:dailyfairdeal/screens/activities/food_activities.dart';
import 'package:dailyfairdeal/screens/activities/mall_activities.dart';
import 'package:dailyfairdeal/screens/activities/taxi_activites.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/custom_tab.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
// Import reusable component

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTabScreen(
      title: 'Activities',
      appBarColor: AppColor.primaryColor,
      titleStyle: AppWidget.appBarTextStyle(),
      tabs: const [
        Tab(icon: Icon(Icons.fastfood, size: 24), text: 'Food'),
        Tab(icon: Icon(Icons.local_taxi, size: 24), text: 'Taxi'),
        Tab(icon: Icon(Icons.store, size: 24), text: 'Mall'),
      ],
      views: const [
        FoodActivities(),
        TaxiActivities(),
        MallActivities(),
      ],
    );
  }
}
