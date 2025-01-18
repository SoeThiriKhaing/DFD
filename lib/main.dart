import 'package:dailyfairdeal/screens/auth/login/login_screen.dart';
import 'package:dailyfairdeal/screens/auth/signup/merchant_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/signup/registerscreen.dart';
import 'package:dailyfairdeal/screens/auth/signup/rider_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/signup/taxi_driver_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/splashscreen.dart';
import 'package:dailyfairdeal/screens/auth/to_register.dart';
import 'package:dailyfairdeal/screens/dashboard/dashboard.dart';
import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_owner_dashboard.dart';
import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_setting/change_restaurant_image.dart';
import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_setting/profile_setting.dart';
import 'package:dailyfairdeal/screens/food/food_category/food_page.dart';
import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/screens/payment/add_card_screen.dart';
import 'package:dailyfairdeal/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
          GetPage(name: '/merchantsignup', page: () => const MerchantSignUp()),
          GetPage(name: '/driversignup', page: () => const TaxiDriverSignUp()),
          GetPage(name: '/dfdridersignup', page: () => const RiderSignUp()),
          GetPage(name: '/foodcategory', page: () => FoodPage()),
          GetPage(name: '/merchantsignup', page: () => const MerchantSignUp()),
          GetPage(name: '/profile', page: () => const Profile()),
          GetPage(name: '/main', page: () => MainScreen()),
          // GetPage(
          //     name: '/popularrestaurant',
          //     page: () => const PopularRestaurantsPage()),
          GetPage(name: '/dashboard', page: () => const Dashboard()),
          GetPage(
              name: '/restaurantownerdashboard',
              page: () => const RestaurantOwnerDashboard()),
          GetPage(name: '/profilesetting', page: () => const ProfileSetting()),
          GetPage(
              name: '/changerestaurantimage',
              page: () => const ChangeRestaurantImage()),
          GetPage(name: '/addcardscreen', page: () => const AddCardScreen()),
        ]);
  }
}
