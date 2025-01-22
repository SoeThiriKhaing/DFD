// import 'package:flutter/material.dart';
// import 'package:dailyfairdeal/controllers/food/all_res_controller.dart';

// class RestaurantList extends StatelessWidget {
//   final AllResController controller;

//   const RestaurantList({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: FutureBuilder<List<Map<String, String>>>(
//       future: controller.loadAllRestaurant(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }

//           if (snapshot.hasData) {
//             final restaurants = snapshot.data ?? [];
//             if (restaurants.isEmpty) {
//               return const Text("No Data for selected category");
//             }

//             return ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
//               itemCount: restaurants.length,
//               itemBuilder: (context, index) {
//                 final restaurant = restaurants[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 3.0,
//                     margin: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: ListTile(
//                       title: Text(restaurant['name'] ?? 'Unnamed Restaurant'),
//                       subtitle: Text(restaurant['res_type'] ?? 'No Type'),
//                       trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
//                       onTap: () {
//                         // Handle restaurant selection
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text("No Data Available"));
//           }
//         },
//       ),
//     );
//   }
// }
