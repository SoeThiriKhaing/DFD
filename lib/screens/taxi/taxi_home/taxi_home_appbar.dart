import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';

class TaxiHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaxiHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Taxi Booking', style: AppWidget.appBarTextStyle()),
      backgroundColor: AppColor.primaryColor,
      //centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
