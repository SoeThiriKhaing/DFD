// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DriverController extends GetxController {
//   var isAvailable = false.obs; // Observable state

//   @override
//   void onInit() {
//     super.onInit();
//     loadAvailability(); // Load state when app starts
//   }

//   void toggleAvailability(bool value) async {
//     isAvailable.value = value;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isAvailable', value); // Save state locally
//   }

//   void loadAvailability() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     isAvailable.value = prefs.getBool('isAvailable') ?? false; // Load saved state
//   }
// }
