import 'package:dailyfairdeal/screens/auth/login/login_screen.dart';
import 'package:dailyfairdeal/screens/auth/signup/merchant/merchant_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/signup/registerscreen.dart';
import 'package:dailyfairdeal/screens/auth/signup/rider_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/signup/taxi_driver_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/splashscreen.dart';
import 'package:dailyfairdeal/screens/auth/to_register.dart';
import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_owner_dashboard.dart';
import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_setting/change_restaurant_image.dart';
import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_setting/profile_setting.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_profile.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/earnings.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/ride_history.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/ride_request.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_home.dart';
import 'package:dailyfairdeal/screens/food/foodpage/food_page.dart';
import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/screens/payment/add_card_screen.dart';
import 'package:dailyfairdeal/screens/profile/profile.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notifications
  var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/dfd');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      handleNotificationClick(response.payload);
    }
  );

  runApp(const MyApp());
}

void handleNotificationClick(String? payload) {
  if (payload == "open_ride_requests") {
    Get.toNamed('/riderequest');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        title: "DailyFairDeal",
        navigatorKey: navigatorKey,
        home: const SplashScreen(),
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen()),
          GetPage(name: '/toregister', page: () => const ToRegister()),
          GetPage(name: '/register', page: () => const RegisterScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/merchantsignup', page: () => const MerchantSignUp()),
          GetPage(name: '/driversignup', page: () => const TaxiDriverSignUp()),
          GetPage(name: '/dfdridersignup', page: () => const RiderSignUp()),
          GetPage(name: '/foodcategory', page: () => const FoodPage()),
          GetPage(name: '/taxihome', page: () => const TaxiHome()),
          GetPage(name: '/merchantsignup', page: () => const MerchantSignUp()),
          GetPage(name: '/profile', page: () => const Profile()),
          GetPage(name: '/main', page: () => MainScreen()),
          GetPage(
              name: '/restaurantownerdashboard',
              page: () => const RestaurantOwnerDashboard()),
          GetPage(name: '/profilesetting', page: () => const ProfileSetting()),
          GetPage(
              name: '/changerestaurantimage',
              page: () => const ChangeRestaurantImage()),
          GetPage(name: '/addcardscreen', page: () => const AddCardScreen()),
          GetPage(name: '/taxi_driver_home', page:()=> const TaxiHomeScreen()),

          GetPage(name: '/riderequest', page: () => const RideRequest()),
          GetPage(name: '/ride_history', page: () => const RideHistory()),
          GetPage(name: '/earnings', page: () => const Earnings()),
           GetPage(name: '/driver_profile', page: () => const DriverProfile()),
        ]);
  }
}
