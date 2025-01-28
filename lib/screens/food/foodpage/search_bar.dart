import 'package:flutter/material.dart';
import 'package:dailyfairdeal/widget/app_color.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
          top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
      child: Material(
        elevation: 5.0,
        shadowColor: Colors.grey,
        //borderRadius: BorderRadius.circular(25.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            hintText: "Search your favorite restaurant...",
            prefixIcon: Icon(Icons.search, color: AppColor.primaryColor),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
