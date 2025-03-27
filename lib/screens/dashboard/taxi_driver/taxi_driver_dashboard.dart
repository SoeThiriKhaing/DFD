import 'dart:async';
import 'package:dailyfairdeal/controllers/taxi/travel/travel_controller.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_profile.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/earning_summary.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/rider_request.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/taxi_driver_home.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/trip_history.dart';
import 'package:dailyfairdeal/services/taxi/travel/travel_service.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({super.key});

  @override
  DriverDashboardState createState() => DriverDashboardState();
}

class DriverDashboardState extends State<DriverDashboard> {
  final travelController = Get.put(TravelController(
    travelService: TravelService(travelRepository: TravelRepository()),
  ));

  final Map<String, dynamic> arguments = Get.arguments;
  late int driverId;

  int notificationCount = 0; 
  Timer? timer;
  
  @override
  void initState(){
    super.initState();
    driverId = arguments['driverId'];
    debugPrint("Driver ID in taxi driver dashboard is $driverId");
    _initialize();
  }

  Future<void> _initialize() async{  
    _fetchRideRequestsCount();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _fetchRideRequestsCount(); // Fetch ride requests every 3 seconds
    });
  }

  int selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const TaxiHomeScreen(),
    const RideRequestsScreen(),
    const EarningsSummaryScreen(),
    const TripHistoryScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      selectedIndex = index;
    });
    Navigator.pop(context); // This closes the drawer
  }

  Future<void> _fetchRideRequestsCount() async {
    try {
      List<TravelModel> requests = await travelController.fetchRiderRequests(driverId);
      if (mounted) {
        setState(() {
          notificationCount = requests.length;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          notificationCount = 0;
        });
      }
    }
  }

   @override
  void dispose() {
    // Cancel the timer when the screen is disposed (when navigating back)
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Dashboard"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  _pageController.jumpToPage(1);
                  setState(() {
                    selectedIndex = 1;
                    notificationCount = 0;
                  });
                },
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
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
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}