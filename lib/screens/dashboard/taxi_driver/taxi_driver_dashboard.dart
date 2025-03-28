import 'dart:async';
import 'package:dailyfairdeal/controllers/taxi/travel/travel_controller.dart';
import 'package:dailyfairdeal/main.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_profile.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/earning_summary.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/get_address_from_latlong.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/rider_request.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/taxi_driver_home.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/trip_history.dart';
import 'package:dailyfairdeal/services/taxi/travel/travel_service.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


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
  void initState() {
    super.initState();

    driverId = arguments['driverId'];
    _initialize();
  }

  Future<void> showRideRequestNotification(String userName, String pickup, String destination) async {
    var androidDetails = const AndroidNotificationDetails(
      "ride_request_channel",
      "Ride Requests",
      channelDescription: "Notifications for new ride requests",
      importance: Importance.high,   // Makes the notification more prominent
      priority: Priority.high,       // Shows the notification on top
      ticker: 'ticker',              // Optional: Adds a ticker message when the notification pops up
      visibility: NotificationVisibility.public, // Ensures it's visible to the top screen
      playSound: true,               // Optional: Play a sound when the notification pops up
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, 
      "New Ride Request", 
      "From $userName. Pickup: $pickup, Destination: $destination.", 
      notificationDetails,
      payload: "open_ride_requests",
    );
  }

  Future<void> _initialize() async{  
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchRideRequestsCount();   
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
    Get.back(); // This closes the drawer using GetX
  }

  Set<int> notifiedTravelIds = <int>{}; // To track already notified ride requests

  Future<void> fetchRideRequestsCount() async {
    try {
      List<TravelModel> requests = await travelController.fetchRiderRequests(driverId);

      if (mounted) {

        for (var request in requests) {
          int travelId = request.travelId!;
          String userName = request.user!.name;
          String pickupLocation = await getAddressFromLatLng(request.pickupLatitude, request.pickupLongitude);
          String destinationLocation = await getAddressFromLatLng(request.destinationLatitude, request.destinationLongitude);

          // Show notification only if the travelId has not been notified already
          if (!notifiedTravelIds.contains(travelId)) {
            showRideRequestNotification(userName, pickupLocation, destinationLocation);
            notifiedTravelIds.add(travelId); // Mark as notified
          }
        }

        // Update notification count properly
        setState(() {
          notificationCount = requests.length; // Keep adding only new notifications
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