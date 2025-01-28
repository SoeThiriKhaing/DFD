import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to Home screen after 10 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed("/toregister"); // Navigate to the "register" screen
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Background for the circular logo
              ),
              child: logoWidget(),
            ),

            const Text(
              "DFD",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColor.primaryColor),
            ),
            const SizedBox(height: 20),
            // Loading Indicator
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
