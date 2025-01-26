import 'package:dailyfairdeal/controllers/food/feature_res_controller.dart';
import 'package:dailyfairdeal/repositories/food/get_feat_res_repository.dart';
import 'package:dailyfairdeal/screens/food/foodpage/category_button.dart';
import 'package:dailyfairdeal/screens/food/foodpage/res_list.dart';
import 'package:dailyfairdeal/services/food/feat_res_service.dart';
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
  late FeatureResController featureResController;
  late Future<List<dynamic>> restaurantList;
  late Future<List<dynamic>> featureList;

  String currentCategory = 'Restaurants'; // Track the selected category

  @override
  void initState() {
    super.initState();
    allResController = AllResController(
      service: AllResService(
        repository: GetAllResRepository(),
      ),
    );
    featureResController = FeatureResController(
        service: FeatResService(repository: GetFeatResRepository()));
    restaurantList = allResController.loadRestaurantList();
    featureList = featureResController.loadFeatureResList();
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
          // Dynamic Content: Display content based on selected category
          Expanded(child: _buildCategoryContent()),
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
                setState(() {
                  currentCategory = 'Restaurants';
                  restaurantList = allResController
                      .loadRestaurantList(); // Reload the restaurant data
                });
              },
            ),
            CategoryButton(
              title: "Featured Restaurants",
              onPressed: () {
                setState(() {
                  currentCategory = 'Featured Restaurants';
                  featureList = featureResController
                      .loadFeatureResList(); // Reload the feature restaurants data
                });
              },
            ),
            CategoryButton(
              title: "Popular Restaurants",
              onPressed: () {
                setState(() {
                  currentCategory = 'Restaurants';
                  restaurantList = allResController
                      .loadRestaurantList(); // Reload the restaurant data
                });
                // Handle popular restaurants category
              },
            ),
            CategoryButton(
              title: "Order It Again",
              onPressed: () {
                setState(() {
                  currentCategory = 'Featured Restaurants';
                  featureList = featureResController
                      .loadFeatureResList(); // Reload the feature restaurants data
                });
                // Handle order again category
              },
            ),
          ],
        ),
      ),
    );
  }

  // Show content based on selected category
  Widget _buildCategoryContent() {
    if (currentCategory == 'Restaurants') {
      return RestaurantList(
        listFuture: restaurantList,
        categoryType: 'Restaurants',
      );
    } else if (currentCategory == 'Featured Restaurants') {
      return RestaurantList(
        listFuture: featureList,
        categoryType: 'Featured Restaurants',
      );
    } else if (currentCategory == 'Popular Restaurants') {
      return RestaurantList(
        listFuture: restaurantList,
        categoryType: 'Restaurants',
      );
    } else if (currentCategory == 'Order It Again') {
      return RestaurantList(
        listFuture: featureList,
        categoryType: 'Featured Restaurants',
      );
    } else {
      return const Center(child: Text('Select a category'));
    }
  }
}
