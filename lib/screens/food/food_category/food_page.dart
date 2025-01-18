import 'package:dailyfairdeal/controllers/food/food_controller.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController()); // Initialize controller

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
          _buildSearchBar(),
          // Scrollable Row of Buttons
          _buildCategoryButtons(controller),
          // Dynamic Content
          _buildDynamicContent(controller),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
      child: Material(
        elevation: 5.0,
        shadowColor: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(25.0),
        child: const TextField(
          decoration: InputDecoration(
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
    );
  }

  Widget _buildCategoryButtons(FoodController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildCategoryButton("Restaurants", () {
              controller.selectedCategory.value = "Restaurants";
              controller.fetchAllRestaurants();
            }),
            _buildCategoryButton("Featured Restaurants", () {
              controller.selectedCategory.value = "Featured Restaurants";
              controller.getFeatureRestaurants();
            }),
            _buildCategoryButton("Popular Restaurants", () {
              controller.selectedCategory.value = "Popular Restaurants";
              controller.fetchOrderAgain();
            }),
            _buildCategoryButton("Popular Foods", () {
              controller.selectedCategory.value = "Popular Foods";
              controller.fetchPopularRestaurants();
            }),
            _buildCategoryButton("Order It Again", () {
              controller.selectedCategory.value = "Order It Again";
              controller.fetchOrderAgain();
            }),
          ],
        ),
      ),
    );
  }

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

  Widget _buildDynamicContent(FoodController controller) {
    return Expanded(
      child: Obx(() {
        final datatoDisplay = controller.getDatatoDisplay();

        if (datatoDisplay.isEmpty) {
          return const Text("No Data For selected category");
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
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
                    item['name'] ?? 'Unnamed Item',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item['description'] ?? "No Description"),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {},
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
