import 'package:dailyfairdeal/screens/widgets/build_card_widget.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Set Up Business Account',
          style: AppWidget.appBarTextStyle(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image at the top
            Container(
                margin: const EdgeInsets.all(10),
                child: Image.asset("assets/images/dfd.png")),
            // Three card views
            buildCard('Restaurant/Shop Owner Account', Colors.white, Icons.shop,
                '/merchantsignup'),
            buildCard('DFD Driver Account', Colors.white,
                Icons.taxi_alert, '/driversignup'),
            buildCard('DFD Rider Account', Colors.white,
                Icons.car_crash, '/dfdridersignup'),
          ],
        ),
      ),
    );
  }
}
