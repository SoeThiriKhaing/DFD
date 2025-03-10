import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';

class RideRequestsScreen extends StatelessWidget {
  const RideRequestsScreen({super.key});

  void _showPriceDialog(BuildContext context, int index) {
    final TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Please define price"),
          content: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter price in Burmese Kyat",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String price = priceController.text;
                if (price.isNotEmpty) {
                  // Handle accept ride logic with the entered price
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text("Ride Request #$index accepted at \$$price")),
                  );
                }
              },
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.location_on,
                  color: AppColor.primaryColor, size: 30),
              title: Text(
                "Ride Request #$index",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Pickup: Location A \nDropoff: Location B"),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                ),
                onPressed: () => _showPriceDialog(context, index),
                child: const Text(
                  "Accept",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class RideRequestsScreen extends StatefulWidget {
//   //final String driverId; // Pass driverId dynamically

//   const RideRequestsScreen({super.key});

//   @override
//   RideRequestsScreenState createState() => RideRequestsScreenState();
// }

// class RideRequestsScreenState extends State<RideRequestsScreen> {
//   List<dynamic> rideRequests = [];
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _fetchRideRequests();
//   }

//   Future<void> _fetchRideRequests() async {
//     final url = Uri.parse(
//         "http://api.dailyfairdeal.com/api/driver/${widget}/notifications");

//     try {
//       final response =
//           await http.get(url, headers: {"Content-Type": "application/json"});

//       if (response.statusCode == 200) {
//         setState(() {
//           rideRequests = json.decode(response.body);
//           isLoading = false;
//         });
//       } else if (response.statusCode == 404) {
//         setState(() {
//           errorMessage = "No ride requests found.";
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = "Failed to load ride requests. Try again.";
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error: $e";
//         isLoading = false;
//       });
//     }
//   }

//   void _acceptRide(int travelId) {
//     // Implement ride acceptance logic here
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Accepted ride request #$travelId")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator()) // Show loader
//           : errorMessage != null
//               ? Center(
//                   child:
//                       Text(errorMessage!, style: const TextStyle(fontSize: 16)))
//               : ListView.builder(
//                   itemCount: rideRequests.length,
//                   itemBuilder: (context, index) {
//                     final request = rideRequests[index];
//                     final user = request["user"];

//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 10),
//                       elevation: 3,
//                       child: ListTile(
//                         leading:
//                             const Icon(Icons.location_on, color: Colors.blue),
//                         title: Text("Ride Request #${request["travel_id"]}"),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                                 "📍 Pickup: ${request["pickup_location"]["latitude"]}, ${request["pickup_location"]["longitude"]}"),
//                             Text(
//                                 "📍 Dropoff: ${request["destination_location"]["latitude"]}, ${request["destination_location"]["longitude"]}"),
//                             Text("👤 Rider: ${user["name"]}"),
//                             Text("📞 Phone: ${user["phone_no"]}"),
//                           ],
//                         ),
//                         trailing: ElevatedButton(
//                           onPressed: () => _acceptRide(request["travel_id"]),
//                           child: const Text("Accept"),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }
