// ignore_for_file: unrelated_type_equality_checks

import 'package:dailyfairdeal/service/food_api/get_feature_res.dart';
import 'package:dailyfairdeal/service/food_api/get_order_again.dart';
import 'package:dailyfairdeal/service/food_api/get_popular_res.dart';
import 'package:dailyfairdeal/service/food_api/get_res_type.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPage extends StatelessWidget {

  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch data when the page loads

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'Food Page',
          style: AppWidget.appBarTextStyle(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Material(
              elevation: 5.0,
              shadowColor: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(25.0),
              child:const TextField(
                //onChanged: apiController.updateSearchQuery,
                decoration:  InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  hintText: "Search your favorite restaurant...",
                  prefixIcon: Icon(Icons.search, color: AppColor.primaryColor),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),

          // Scrollable Row of Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton("Restaurants", () {
                    selectedCategory.value = "Restaurants" as List;
                    getRestaurantTypes();
                  }),
                  _buildCategoryButton('Featured Restaurants', () {
                    selectedCategory.value =
                        "Featured Restaurants" as List;
                    getFeatureRestaurants();
                  }),
                  _buildCategoryButton('Popular Restaurants', () {
                    selectedCategory.value =
                        "Popular Restaurants" as List;
                    fetchOrderAgain();
                  }),
                  _buildCategoryButton('Popular Foods', () {
                  selectedCategory.value = "Popular Foods" as List;
                    fetchPopularRestaurants();
                  }),
                  _buildCategoryButton('Order It Again', () {
                    selectedCategory.value = "Order It Again" as List;

                    fetchOrderAgain();
                  }),
                ],
              ),
            ),
          ),

          // Dynamic Content
          Expanded(
            child: Obx(() {
              //final selectedCategory = selectedCategory.value;
              final datatoDisplay = selectedCategory == "Featured Restaurants"
                  ? featuredRestaurants
                  : selectedCategory == "Popular Restaurants"
                      ? orderAgain
                      : selectedCategory == "Popular Foods"
                          ? popularRestaurant
                          : selectedCategory == "Restaurants"
                              ? popularRestaurant
                              : orderAgain;
              if (datatoDisplay.isEmpty) {
                return const Text("No Data For selected category");
              }
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                itemCount: datatoDisplay.length,
                itemBuilder: (context, index) {
                  final item = datatoDisplay[index];
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
                        title: Text(
                          selectedCategory == "Popular Foods"
                              ? item['name'] ?? 'Unnamed Food'
                              : selectedCategory == "Feature Restaurants"
                                  ? item['name'] ?? "No Feature Restaurant"
                                  : selectedCategory == "Restaurants"
                                      ? item['name'] ?? "Unnamed Restaurants"
                                      : item['name'] ??
                                          "No Data for Restaurants",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: selectedCategory == "Featured Restaurants"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${item['restaurant_type'] ?? "No Subcategory"}"),
                                  Text("${item['avg_rating'] ?? "No Rating"}"),
                                  Text(
                                      "${item['open_time'] ?? "No Subcategory"}"),
                                  Text("${item['close_time'] ?? "No Rating"}"),
                                  Text("${item['user_name'] ?? "No Rating"}"),
                                ],
                              )
                            : selectedCategory == "Popular Foods"
                                ? Text(
                                    "${item['sub_category_id'] ?? 'No Subcategory'}",
                                    style: const TextStyle(fontSize: 14),
                                  )
                                : selectedCategory == "Order It Again"
                                    ? Text(
                                        "${item['restaurant_type'] ?? 'No Subcategory'}",
                                      )
                                    : selectedCategory == "Restaurants"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${item['restaurant_type'] ?? "No Subcategory"}"),
                                              Text(
                                                  "${item['avg_rating'] ?? "No Rating"}"),
                                              Text(
                                                  "${item['open_time'] ?? "No Subcategory"}"),
                                              Text(
                                                  "${item['close_time'] ?? "No Rating"}"),
                                              Text(
                                                  "${item['user_name'] ?? "No Rating"}"),
                                            ],
                                          )
                                        : const Text("No Data"),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey),
                        onTap: () {},
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Helper Method to Build Category Buttons
  Widget _buildCategoryButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
