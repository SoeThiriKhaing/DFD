import 'package:dailyfairdeal/screens/taxi/driver_dashboard/taxi_driver_dashboard.dart';
import 'package:dailyfairdeal/screens/taxi/tax_example.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/auth/splashscreen.dart';
import 'screens/auth/to_register.dart';
import 'screens/auth/signup/registerscreen.dart';
import 'screens/auth/login/login_screen.dart';
import 'screens/auth/signup/taxi_driver_sign_up.dart';
import 'screens/auth/signup/rider_sign_up.dart';
import 'screens/food/foodpage/food_page.dart';
import 'screens/profile/profile.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/dashboard/restaurant/restaurant_owner_dashboard.dart';
import 'screens/dashboard/restaurant/restaurant_setting/change_restaurant_image.dart';
import 'screens/dashboard/restaurant/restaurant_setting/profile_setting.dart';
import 'screens/payment/add_card_screen.dart';
import 'screens/home/main_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // Ensure Firebase is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DailyFairDeal",
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/toregister', page: () => const ToRegister()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        //GetPage(name: '/merchantsignup', page: () => const MerchantSignUp()),
        GetPage(name: '/driversignup', page: () => const TaxiDriverSignUp()),
        GetPage(name: '/dfdridersignup', page: () => const RiderSignUp()),
        GetPage(name: '/foodcategory', page: () => const FoodPage()),
        GetPage(name: '/taxicategory', page: () => const TaxiHome()),
        GetPage(name: '/profile', page: () => const Profile()),
        GetPage(name: '/main', page: () => MainScreen()),
        GetPage(name: '/dashboard', page: () => const Dashboard()),
        GetPage(
            name: '/restaurantownerdashboard',
            page: () => const RestaurantOwnerDashboard()),
        GetPage(name: '/profilesetting', page: () => const ProfileSetting()),
        GetPage(
            name: '/changerestaurantimage',
            page: () => const ChangeRestaurantImage()),
        GetPage(name: '/addcardscreen', page: () => const AddCardScreen()),
        GetPage(name: '/driverdashboard', page: () => const DriverDashboard()),
      ],
    );
  }
}
