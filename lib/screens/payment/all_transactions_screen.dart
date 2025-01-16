import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
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
          'All Transactions',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        elevation: 4.0, // Adds elevation to the AppBar
      ),
      body: const Center(
        child: Text(
          'Nothing here yet!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
