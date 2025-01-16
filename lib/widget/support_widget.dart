import 'package:flutter/material.dart';

class AppWidget {
  static labelTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  static buttonTextStyle() {
    return const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

   static subTitle() {
    return const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static carouselTextStyle() {
    return const TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);
  }

  static appBarTextStyle() {
    return const TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black);
  }

  //TextFormField Label TextStyle
  static formFieldLabelTextStyle() {
    return const TextStyle(
      fontSize: 18.0,
    );
  }

  headerTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}