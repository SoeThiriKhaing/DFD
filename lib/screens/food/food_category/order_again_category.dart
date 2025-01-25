import 'package:dailyfairdeal/controllers/food/order_again_controller.dart';
import 'package:flutter/material.dart';

class OrderAgainCategory extends StatelessWidget {
  final OrderAgainController controller;

  const OrderAgainCategory({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List>(
        // Changed the type here to Map<String, Object>
        future: controller.loadOrderAgain(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.hasData) {
            final orderAgain = snapshot.data ?? [];
            if (orderAgain.isEmpty) {
              return const Text("No Data for selected category");
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              itemCount: orderAgain.length,
              itemBuilder: (context, index) {
                final orderAgains = orderAgain[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(orderAgains['name']?.toString() ??
                            'Unnamed Restaurant'),
                        subtitle: Text(
                            orderAgains['res_type']?.toString() ?? 'No Type'),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey),
                        onTap: () {
                          // Handle restaurant selection
                        },
                      )),
                );
              },
            );
          } else {
            return const Center(child: Text("No Data Available"));
          }
        },
      ),
    );
  }
}
