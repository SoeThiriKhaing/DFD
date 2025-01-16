import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/reusabel_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToRegister extends StatelessWidget {
  const ToRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: AppColor.primaryColor),
            width: Get.width, // Used Get.width for responsiveness.
            height: 400,
            child: Image.asset(
              "assets/images/dfd.png",
              //fit: BoxFit.cover, // Ensured the image fits properly.
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(70.0),
                topRight: Radius.circular(70.0),
              ),
              child: Container(
                color: Colors.white,
                width: Get.width, // Full screen width for the bottom container.
                padding: const EdgeInsets.symmetric(
                  vertical: 80.0,
                  horizontal: 30.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Adapt to content size.
                  children: [
                    const Text(
                      "Welcome!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Sign Up or Login To Continue",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Add Facebook login functionality here
                        },
                        label: const Text("Continue with Facebook"),
                        icon: const Icon(Icons.facebook),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Add Google login functionality here
                        },
                        label: const Text("Continue with Google"),
                        icon: const Icon(Icons.facebook), // Fixed icon.
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text("or"),
                    const SizedBox(height: 20.0),
                    ReusableButton(
                      text: "Sign Up",
                      onPressed: () {
                        Get.toNamed("/register");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
