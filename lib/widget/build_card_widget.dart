import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildCard(String title, Color color, IconData icon, String route) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(route);
    },
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: AppColor.primaryColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}
