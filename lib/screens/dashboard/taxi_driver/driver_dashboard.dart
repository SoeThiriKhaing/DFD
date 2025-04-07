import 'dart:async';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/controllers/taxi/travel/travel_controller.dart';
import 'package:dailyfairdeal/main.dart';
import 'package:dailyfairdeal/models/taxi/travel/travel_model.dart';
import 'package:dailyfairdeal/repositories/taxi/travel/travel_repository.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/get_address_from_latlong.dart';
import 'package:dailyfairdeal/services/taxi/travel/travel_service.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'driver_drawer.dart';

class DriverDashboard extends StatefulWidget {
  final Widget child; // Screen to show inside the layout
  const DriverDashboard({required this.child, super.key});

  @override
  State<DriverDashboard>  createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  
  final travelController = Get.put(TravelController(
    travelService: TravelService(travelRepository: TravelRepository()),
  ));

  int? driverId;

  int notificationCount = 0; 
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _getDriverId();
    _initialize();
  }

  @override
  void dispose() {
    // Cancel the timer when the screen is disposed (when navigating back)
    timer?.cancel();
    super.dispose();
  }

  Future<void> _initialize() async{  
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchRideRequestsCount();   
    });
  }

  Future<void> _getDriverId() async {
    String? taxiDriverId = await getDriverId(); // From the Secure Storage
    driverId = int.parse(taxiDriverId!);
  }

  Set<int> notifiedTravelIds = <int>{}; // To track already notified ride requests

  Future<void> fetchRideRequestsCount() async {
    try {
      List<TravelModel> requests = await travelController.fetchRiderRequests(driverId!);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text("Taxi Driver Dashboard"),
        actions:[
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Get.toNamed('/riderequest');
                  setState(() {
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
      drawer: const DriverDrawer(),
      body: widget.child, // Display the screen inside the body
    );
  }
}
