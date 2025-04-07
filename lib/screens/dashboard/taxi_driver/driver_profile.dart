import 'package:dailyfairdeal/controllers/taxi/driver/driver_controller.dart';
import 'package:dailyfairdeal/models/taxi/driver/driver_model.dart';
import 'package:dailyfairdeal/repositories/taxi/driver/driver_repository.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_dashboard.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/services/taxi/driver/driver_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  int? driverId;
  String? driverName;
  String? driverPhone;
  String? driverEmail;
  String? vehicle;
  String? licenseNo;

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
      driverPhone = driver.user?.phone;
      vehicle = driver.carModel;
      licenseNo = driver.licensePlate;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DriverDashboard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Profile Image
            const Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/driver.png"),
              ),
            ),
            const SizedBox(height: 15),
            // Driver Name
            Text(
              driverName ?? "Loading..",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            // Driver Details
            const SizedBox(height: 10),
            Text("📞 Phone: ${driverPhone ?? 'Loading...'}",
                style: const TextStyle(fontSize: 16)),
            Text("✉️ Email: ${driverEmail ?? 'Loading...'}",
                style: const TextStyle(fontSize: 16)),
            Text("🚗 Vehicle: ${vehicle ?? 'Loading...'}",
                style: const TextStyle(fontSize: 16)),
            Text("📄 License No: ${licenseNo ?? 'Loading...'}",
                style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            // Edit Profile Button
            ElevatedButton(
              onPressed: () {
                // Edit profile logic
              },
              child: const Text("Edit Profile"),
            ),

            const Spacer(),

            // Delete Account Button
            TextButton(
              onPressed: (){},
              child: const Text(
                "Delete Account",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}