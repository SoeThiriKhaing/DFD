import 'package:dailyfairdeal/screens/payment/all_payment_methods.dart';
import 'package:dailyfairdeal/widget/build_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinanceSetting extends StatefulWidget {
  const FinanceSetting({super.key});

  @override
  State<FinanceSetting> createState() => _FinanceSettingState();
}

class _FinanceSettingState extends State<FinanceSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Finance Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            const Text(
              "Payments",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )
            ),
            const SizedBox(height: 10),
            // Payment Section
            buildSection(
              icon: Icons.payment,
              title: 'All Payment Methods',
              subtitle: 'Manage your payment methods and top ups',
              onTap: () {
                Get.to(() => const AllPaymentMethods());
              },
            ),

            const SizedBox(height: 20),
            const Text(
              "Security",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )
            ),
            const SizedBox(height: 10),
        
            // Security Section
            buildSection(
              icon: Icons.lock,
              title: 'DFD PIN',
              subtitle: 'Create or reset your PIN',
              onTap: () {
                //Get.to(() => const DfdPinScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
 
}
