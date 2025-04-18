import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_owner_dashboard.dart';
import 'package:dailyfairdeal/screens/profile/business.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  // final List<Map<String, String>> items = [
  //   {'title': 'Profile Details'},
  //   {'title': 'Order & Reordering'},
  //   {'title': 'Vouchers'},
  //   {'title': 'Favourites'},
  //   {'title': 'Setting'},
  //   {'title': 'Safety Setting'},
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: AppWidget.appBarTextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider
            CarouselSlider(
              items: [
                Image.asset("assets/images/dfd.png"),
                Image.asset("assets/images/food1.jpeg"),
                Image.asset("assets/images/food2.jpeg"),
              ],
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            const SizedBox(height: 30),

            Center(child: Text("List your business on DailyFairDeal!", style: AppWidget.subTitle())),
            Center(child: Text("Be Our Partner?", style: AppWidget.subTitle())),
            const SizedBox(height: 5),

            // Card View
            GestureDetector(
              onTap: () {
                Get.to(() => const BusinessPage()); 
              },
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Business Centre',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.business_center,
                        size: 40.0,
                        color: AppColor.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Center(child: Text("Your Dashboard", style: AppWidget.subTitle())),
            const SizedBox(height: 5),

            // Card View
            GestureDetector(
              onTap: () {
                Get.to(() => const RestaurantOwnerDashboard()); 
              },
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Merchant Dashboard',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.dashboard,
                        size: 40.0,
                        color: AppColor.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text("General", style: AppWidget.subTitle()),
            ),
            const SizedBox(height: 10),
            
            // List View
            ListView(
              shrinkWrap: true, // Prevents infinite height error
              physics: const NeverScrollableScrollPhysics(), // Prevents list view from scrolling
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: const Text('Profile Details'),
                  subtitle: const Text('View and edit your profile information.'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to Profile Details page or perform an action
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart, color: Colors.green),
                  title: const Text('Orders & Reordering'),
                  subtitle: const Text('Track and reorder your past orders.'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to Orders & Reordering page or perform an action
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.card_giftcard, color: Colors.orange),
                  title: const Text('Vouchers'),
                  subtitle: const Text('Check available vouchers and discounts.'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to Vouchers page or perform an action
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: const Text('Favourites'),
                  subtitle: const Text('View your saved favorite items.'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to Favourites page or perform an action
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.grey),
                  title: const Text('Settings'),
                  subtitle: const Text('Manage your account settings.'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to Settings page or perform an action
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.security, color: Colors.purple),
                  title: const Text('Safety Settings'),
                  subtitle: const Text('Update your safety and privacy settings.'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to Safety Settings page or perform an action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
