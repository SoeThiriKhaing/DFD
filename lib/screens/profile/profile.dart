import 'package:dailyfairdeal/screens/profile/business.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/screens/widgets/build_list_tile_widget.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                Image.asset("assets/images/food2.jpeg")
              ],
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            const SizedBox(height: 30),

            Center(
                child: Text("List your business on DailyFairDeal!",
                    style: AppWidget.subTitle())),
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

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text("General", style: AppWidget.subTitle()),
            ),
            const SizedBox(height: 10),

            // List View
            ListView(
              shrinkWrap: true, // Prevents infinite height error
              physics:
                  const NeverScrollableScrollPhysics(), // Prevents list view from scrolling
              children: [
                buildListTile(icon: Icons.dashboard_customize, iconColor: Colors.yellow, title: "Your Dashboard", subtitle: "Go and view your dashboard.", onTap: (){ Get.toNamed("/dashboard");}),
                buildListTile(icon: Icons.person, iconColor: Colors.blue, title: "Profile Details", subtitle: "View and edit your profile information.", onTap: (){}),
                buildListTile(icon: Icons.shopping_cart, iconColor: Colors.green, title: "Orders & Reordering", subtitle: "Track and reorder your past orders.", onTap: (){}),
                buildListTile(icon: Icons.card_giftcard, iconColor: Colors.orange, title: "Vouchers", subtitle: "Check available vouchers and discounts.", onTap: (){}),
                buildListTile(icon: Icons.favorite, iconColor: Colors.red, title: "Favourites", subtitle: "View your saved favorite items.", onTap: (){}),
                buildListTile(icon: Icons.settings, iconColor: Colors.grey, title: "Settings", subtitle: "Manage your account settings.", onTap: (){}),
                buildListTile(icon: Icons.security, iconColor: Colors.purple, title: "Safety Settings", subtitle: "Update your safety and privacy settings.", onTap: (){}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
