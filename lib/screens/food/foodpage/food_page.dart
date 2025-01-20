import 'package:dailyfairdeal/screens/food/foodpage/category_button.dart';
import 'package:dailyfairdeal/screens/food/food_category/all_restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:dailyfairdeal/widget/app_color.dart';

import 'package:dailyfairdeal/controllers/food/all_res_controller.dart';
import 'package:dailyfairdeal/services/food/all_res_service.dart';
import 'package:dailyfairdeal/repositories/food/get_all_res_repository.dart'; // Assuming this exists

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late AllResController allResController;

  @override
  void initState() {
    super.initState();
    allResController = AllResController(
      service: AllResService(
        repository: GetAllResRepository(),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Food Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          const SearchBar(),
          // Category Buttons
          _buildCategoryButtons(),
          // Dynamic Content: Restaurant List
          RestaurantList(controller: allResController),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CategoryButton(
              title: "Restaurants",
              onPressed: () {
                allResController.loadAllRestaurant();
              },
            ),
            CategoryButton(
              title: "Featured Restaurants",
              onPressed: () {
                // Handle category for featured restaurants
              },
            ),
            CategoryButton(
              title: "Popular Restaurants",
              onPressed: () {
                // Handle popular restaurants category
              },
            ),
            CategoryButton(
              title: "Order It Again",
              onPressed: () {
                // Handle order again category
              },
            ),
          ],
        ),
      ),
    );
  }
}
