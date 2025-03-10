import 'package:dailyfairdeal/screens/taxi/driver_dashboard/driver_profile.dart';
import 'package:dailyfairdeal/screens/taxi/driver_dashboard/earning_summary.dart';
import 'package:dailyfairdeal/screens/taxi/driver_dashboard/rider_request.dart';
import 'package:dailyfairdeal/screens/taxi/driver_dashboard/taxi_home.dart';
import 'package:dailyfairdeal/screens/taxi/driver_dashboard/trip_history.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({super.key});

  @override
  DriverDashboardState createState() => DriverDashboardState();
}

class DriverDashboardState extends State<DriverDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const TaxiHomeScreen(),
    const RideRequestsScreen(),
    EarningsSummaryScreen(),
    TripHistoryScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text('Driver Dashboard', style: AppWidget.appBarTextStyle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Rides'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Earnings'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => _onItemTapped(4),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
