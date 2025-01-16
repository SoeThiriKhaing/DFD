// import 'dart:convert'; // For jsonDecode
// import 'package:dailyfairdeal/services/secure_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:http/http.dart' as http;

// class APIMethods extends GetxController {
//   var featuredRestaurants = [].obs;
//   var popularFoods = [].obs;
//   var favoriteCuisines = [].obs;
//   var orderAgain = [].obs;
//   var filteredFoods = [].obs;
//   var restaurant = [].obs;
//   var popularRestaurant = [].obs;
//   var favouriteCuisines = [].obs;
//   var filteredCategories = [].obs;

//   var selectedCategory = ''.obs;

//   Future<List<Map<String, dynamic>>> searchItemsByType(
//       String query, String type) async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         throw Exception("Unauthorized: Token not found");
//       }
//       final uri = Uri.parse("http://api.dailyfairdeal.com/api/search");

//       // JSON body
//       final body = json.encode({
//         'q': query,
//         'type': type,
//       });

//       // Make the POST request
//       final response = await http.post(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: body,
//       );

//       // Handle the response
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return List<Map<String, dynamic>>.from(data['data']);
//       } else if (response.statusCode == 401) {
//         throw Exception("Unauthorized: Invalid credentials");
//       } else if (response.statusCode == 500) {
//         throw Exception("Server error. Please try again later.");
//       } else {
//         throw Exception("Failed to load search results");
//       }
//     } catch (e) {
//       throw Exception("Error: $e");
//     }
//   }

//   Future<void> getFeatureRestaurants() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         throw Exception("Unauthorized:Token not found");
//       }
//       final response = await http.get(
//           Uri.parse("http://api.dailyfairdeal.com/api/feature-restaurants"),
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $token',
//           });
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
//         final List<dynamic> dataList = decodedResponse['data'];
//         print(dataList);
//         featuredRestaurants.value = dataList;
//       } else if (response.statusCode == 204) {
//         showError("No orders available at the moment.");
//       } else if (response.statusCode == 401) {
//         showError("Unauthorized access. Please log in again.");
//       } else {
//         showError("Failed to load orders. Please try again later.");
//         print("Status Code: ${response.statusCode}");
//         print("Response Body: ${response.body}");
//       }
//     } catch (e) {
//       showError("An error occurred: $e");
//     }
//   }

//   //Order Again

//   Future<void> fetchOrderAgain() async {
//     try {
//       final token = await getToken(); // Retrieve the token
//       if (token == null) {
//         throw Exception("Unauthorized: Token not found");
//       }

//       final response = await http.get(
//         Uri.parse('http://api.dailyfairdeal.com/api/order-it-again'),
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $token',
//         },
//       );

//       print(response.statusCode);

//       if (response.statusCode == 200) {
//         // Decode the response body
//         final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

//         // Extract and return the 'data' list
//         final List<dynamic> dataList = decodedResponse['data'];
//         print(dataList);
//         // Ensure correct typing as List<Map<String, dynamic>>
//         orderAgain.value = dataList;
//         // return List<Map<String, dynamic>>.from(dataList);
//       } else if (response.statusCode == 204) {
//         showError("No orders available at the moment.");
//       } else if (response.statusCode == 401) {
//         showError("Unauthorized access. Please log in again.");
//       } else {
//         showError("Failed to load orders. Please try again later.");
//         print("Status Code: ${response.statusCode}");
//         print("Response Body: ${response.body}");
//       }
//     } catch (e) {
//       showError("An error occurred: $e");
//     }
//   }

// //Fetch Popular Restaurants

//   Future<void> fetchPopularRestaurants() async {
//     try {
//       final token = await getToken(); // Retrieve the token
//       if (token == null) {
//         throw Exception("Unauthorized: Token not found");
//       }

//       final response = await http.get(
//         Uri.parse('http://api.dailyfairdeal.com/api/order-it-again'),
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $token',
//         },
//       );

//       print(response.statusCode);

//       if (response.statusCode == 200) {
//         // Decode the response body
//         final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

//         // Extract and return the 'data' list
//         final List<dynamic> dataList = decodedResponse['data'];
//         print(dataList);
//         // Ensure correct typing as List<Map<String, dynamic>>
//         orderAgain.value = dataList;
//         // return List<Map<String, dynamic>>.from(dataList);
//       } else if (response.statusCode == 204) {
//         showError("No orders available at the moment.");
//       } else if (response.statusCode == 401) {
//         showError("Unauthorized access. Please log in again.");
//       } else {
//         showError("Failed to load orders. Please try again later.");
//         print("Status Code: ${response.statusCode}");
//         print("Response Body: ${response.body}");
//       }
//     } catch (e) {
//       showError("An error occurred: $e");
//     }
//   }

//   // Handle search queryf
//   void updateSearchQuery(String query) {
//     filteredCategories.value = featuredRestaurants
//         .where((restaurant) =>
//             restaurant['name'].toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// //Fetch FeatureRestaurants

//   Future<void> fetchFavouriteCuisines() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         throw Exception("Unauthorized: Token not found");
//       }
//       final response = await http.get(
//         Uri.parse("http://api.dailyfairdeal.com/api/favorite-cuisine"),
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         favouriteCuisines.value = data;
//       } else if (response.statusCode == 401) {
//         Get.snackbar("Error", "Unauthorized access.",
//             snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
//       } else {
//         Get.snackbar("Error", "Failed to load data.",
//             snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e",
//           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
//     }
//   }

//   Future<void> fetchPopularFoods() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         throw Exception("Unauthorized: Token not found");
//       }

//       final response = await http.get(
//         Uri.parse('http://api.dailyfairdeal.com/api/popular-foods'),
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> rawData = jsonDecode(response.body);
//         // Map data to ensure correct types
//         final data = rawData.map((item) {
//           return {
//             'name': item['name'] ?? 'Unknown',
//             'sub_category_id': item['sub_category_id'].toString() ?? 'N/A',
//             'date': item['created_at']
//           };
//         }).toList();

//         popularFoods.value = data;
//         // filteredFoods.value = data; // Initialize filtered list
//       } else if (response.statusCode == 401) {
//         showError("Unauthorized access. Please log in again.");
//       } else {
//         showError("Failed to load data. Please try again.");
//       }
//     } catch (e) {
//       showError("An error occurred: $e");
//     }
//   }

//   void showError(String message) {
//     Get.snackbar(
//       "Error",
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.red,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(10),
//       borderRadius: 10,
//     );
//   }

//   Future<void> fetchFavoriteCuisines() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         throw Exception("Unauthorized: Token not found");
//       }
//       final response = await http.get(
//         Uri.parse('http://api.dailyfairdeal.com/api/favorite-cuisine'),
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         popularFoods.value = jsonDecode(response.body);
//       } else if (response.statusCode == 401) {
//         Get.snackbar("Error", "Unauthorized access.",
//             snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
//       } else {
//         Get.snackbar("Error", "Failed to load data.",
//             snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e",
//           snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
//     }
//   }

//   //Fetch Restaurants
//   Future<void> fetchRestaurants() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         throw Exception("Unauthorized: Token not found");
//       }
//       final response = await http.get(
//         Uri.parse('http://api.dailyfairdeal.com/api/restaurant'),
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $token',
//         },
//       );
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         // Decode the response body
//         final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

//         // Extract and return the 'data' list
//         final List<dynamic> dataList = decodedResponse['data'];
//         print(dataList);
//         // Ensure correct typing as List<Map<String, dynamic>>
//         restaurant.value = dataList;
//         // return List<Map<String, dynamic>>.from(dataList);
//       } else if (response.statusCode == 204) {
//         showError("No orders available at the moment.");
//       } else if (response.statusCode == 401) {
//         showError("Unauthorized access. Please log in again.");
//       } else {
//         showError("Failed to load orders. Please try again later.");
//         print("Status Code: ${response.statusCode}");
//         print("Response Body: ${response.body}");
//       }
//     } catch (e) {
//       showError("An error occurred: $e");
//     }
//   }

//   void updateCategory(String category) {
//     selectedCategory.value = category;
//   }

//   Future<void> saveRestaurantData(Map<String, dynamic> data) async {
//     try{
//       final token = await getToken();
//       if (token == null) {
//         throw Exception("Unauthorized: Token not found");
//       }
//       const String url = "http://api.dailyfairdeal.com/api/restaurant";
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "application/json", 'Authorization': 'Bearer $token'},
//         body: json.encode(data),
//       );
//       if(response.statusCode == 201){
//         Get.snackbar(
//           "Success",
//           "Restaurant data saved successfully!",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//       }
//       else if(response.statusCode == 500){
//         Get.snackbar(
//           "Error",
//           "Internal Server Error. Please try again.",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//        else if (response.statusCode == 401) {
//         Get.snackbar(
//           "Error",
//           "Unauthorized access.",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red
//         );
//       } else {
//         Get.snackbar(
//           "Error",
//           "Failed to save data.",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red
//         );
//       }     

//     }catch(e){
//       Get.snackbar("Error", "Failed to save data, $e", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
//     }
    
//   }
// }
