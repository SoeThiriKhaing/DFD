import 'dart:async';
import 'package:dailyfairdeal/controllers/taxi/driver/driver_controller.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/driver_repository.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_service.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverDrawer extends StatefulWidget {
  const DriverDrawer({super.key});

  @override
  State<DriverDrawer> createState() => _DriverDrawerState();
}

class _DriverDrawerState extends State<DriverDrawer> {
  int? driverId;
  String? driverName;
  String? driverEmail;

  DriverController driverController = Get.put(DriverController(service: DriverService(repository: DriverRepository())));

  @override
  void initState() {
    super.initState();
    _initializeDriverData();
  }

  Future<void> _initializeDriverData() async {
    await _getDriverId();
    if (driverId != null) {
      await getDriverInfo(driverId!);
    }
  }

  Future<void> _getDriverId() async {
    String? taxiDriverId = await getDriverId(); // Fetch from Secure Storage
    if (taxiDriverId != null) {
      setState(() {
        driverId = int.tryParse(taxiDriverId);
      });
    }
  }

  Future<void> getDriverInfo(int driverId) async {
    DriverModel driver = await driverController.fetchTaxiDriverByDriverId(driverId);
    setState(() {
      driverName = driver.user?.name ?? "Driver Name";
      driverEmail = driver.user?.email ?? "driver@gmail.com";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColor.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.account_circle, size: 50, color: Colors.white),
                const SizedBox(height: 10),
                Text(driverName ?? "Loading...", style: const TextStyle(color: Colors.white, fontSize: 18)),
                Text(driverEmail ?? "Loading...", style: const TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Get.back(); // Close the drawer
              if (Get.currentRoute != '/taxi_driver_home') {
                Get.offNamed('/taxi_driver_home');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text('Ride Requests'),
            onTap: () {
              Get.back();
              if (Get.currentRoute != '/riderequest') {
                Get.offNamed('/riderequest');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Ride History"),
            onTap: () {
              Get.back();
              if (Get.currentRoute != '/ride_history') {
                Get.offNamed('/ride_history');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Earnings'),
            onTap: () {
              Get.back();
              if (Get.currentRoute != '/earnings') {
                Get.offNamed('/earnings');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Get.back();
              if (Get.currentRoute != '/driver_profile') {
                Get.offNamed('/driver_profile');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.switch_account),
            title: const Text("Go To User Panel"),
            onTap: () {
              Get.back();
              if (Get.currentRoute != '/driver_profile') {
                Get.offAllNamed('/profile');
              }
            },
          ),
        ],
      ),
    );
  }
}
