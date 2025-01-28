import 'package:flutter/material.dart';

class CustomTabScreen extends StatelessWidget {
  final String title;
  final List<Tab> tabs;
  final List<Widget> views;
  final Color appBarColor;
  final TextStyle? titleStyle;

  const CustomTabScreen({
    super.key,
    required this.title,
    required this.tabs,
    required this.views,
    this.appBarColor = Colors.blue,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: appBarColor,
          title: Text(title, style: titleStyle ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: views,
        ),
      ),
    );
  }
}
