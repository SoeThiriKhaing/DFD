import 'package:dailyfairdeal/screens/payment/add_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPaymentMethods extends StatefulWidget {
  const AllPaymentMethods({super.key});

  @override
  State<AllPaymentMethods> createState() => _AllPaymentMethodsState();
}

class _AllPaymentMethodsState extends State<AllPaymentMethods> {
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
          'All Payment Methods',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 4.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Add Methods',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const AddCardScreen());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: Colors.grey, // Background color of the circle
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.credit_card,
                      size: 30,
                      color: Colors.black, // Icon color
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Card',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
