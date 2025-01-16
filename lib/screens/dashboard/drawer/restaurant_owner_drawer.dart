import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantOwnerDrawer extends StatelessWidget {
  const RestaurantOwnerDrawer({super.key});

  // Reusable ListTile widget
  Widget buildListTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  // Reusable ExpansionTile widget with children
  Widget buildExpansionTile({
    required IconData leadingIcon,
    required String title,
    required List<Map<String, dynamic>> children,
  }) {
    return ExpansionTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      children: children
          .map(
            (child) => buildListTile(
              icon: Icons.arrow_right,
              title: child['title'],
              onTap: child['onTap'],
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/dfd.png'),
                ),
                SizedBox(height: 5),
                Text(
                  'Restaurant Owner',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'owner@restaurant.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          // Drawer Items
          buildListTile(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => Get.toNamed("/restaurantownerdashboard"),
          ),
          buildExpansionTile(
            leadingIcon: Icons.restaurant,
            title: 'Restaurant',
            children: [
              {'title': 'Profile Setting', 'onTap': () => Get.toNamed("/profilesetting")},
              {'title': 'Change Image', 'onTap': () => Get.toNamed("/changerestaurantimage")},
            ],
          ),
          buildExpansionTile(
            leadingIcon: Icons.fastfood,
            title: 'Food Management',
            children: [
              {'title': 'Add Category', 'onTap': () => Get.back()},
              {'title': 'Add Food', 'onTap': () => Get.back()},
              {'title': 'Food List', 'onTap': () => Get.back()},
            ],
          ),
          buildExpansionTile(
            leadingIcon: Icons.list,
            title: 'Order Management',
            children: [
              {'title': 'Order List', 'onTap': () => Get.back()},
              {'title': 'Order History', 'onTap': () => Get.back()},
              {'title': 'Confirm or Cancel Orders', 'onTap': () => Get.back()},
            ],
          ),
          buildExpansionTile(
            leadingIcon: Icons.report,
            title: 'Reports & Analytics',
            children: [
              {'title': 'Sales Reports', 'onTap': () => Get.back()},
              {'title': 'Popular Items', 'onTap': () => Get.back()},
              {'title': 'Customer Trends', 'onTap': () => Get.back()},
            ],
          ),
          buildExpansionTile(
            leadingIcon: Icons.discount,
            title: 'Promotions & Discounts',
            children: [
              {'title': 'Manage Discounts', 'onTap': () => Get.back()},
              {'title': 'Special Offers', 'onTap': () => Get.back()},
              {'title': 'Promotions', 'onTap': () => Get.back()},
            ],
          ),
          buildExpansionTile(
            leadingIcon: Icons.settings,
            title: 'Settings',
            children: [
              {'title': 'Payment Settings', 'onTap': () => Get.back()},
              {'title': 'Security Settings', 'onTap': () => Get.back()},
            ],
          ),
          const Divider(),
          buildListTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => Get.toNamed("/main"),
          ),
        ],
      ),
    );
  }
}
