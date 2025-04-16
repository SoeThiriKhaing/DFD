import 'package:carousel_slider/carousel_slider.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isLoading = false;
  String selectedType = "food";
  String? userName;

  final List<Map<String, String>> featureRestaurantsList = [
    {'name': 'Pizza Paradise', 'restaurant_type': 'Italian'},
    {'name': 'Burger Haven', 'restaurant_type': 'Fast Food'},
    {'name': 'Sushi Central', 'restaurant_type': 'Japanese'},
    {'name': 'Taco Fiesta', 'restaurant_type': 'Mexican'},
    {'name': 'Curry House', 'restaurant_type': 'Indian'},
    {'name': 'Dragon Wok', 'restaurant_type': 'Chinese'},
  ];

  Future<void> performSearch() async {
    String query = searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeUserName();
  }

  Future<void> initializeUserName() async {
    userName = await getUserName();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        leading: const Icon(
          Icons.person,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text(
          "Hello, $userName",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                elevation: 8.0,
                shadowColor: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(50.0),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Search.....",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onSubmitted: (value) => performSearch(),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Card View
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // buildCard("Taxi", Icons.car_crash, AppColor.primaryColor,
                  //     '/taxihome'),
                  buildCard("Taxi", Icons.car_crash, AppColor.primaryColor,
                      '/taxi_home_screen'),
                  buildCard("Food", Icons.food_bank_rounded,
                      AppColor.primaryColor, '/foodcategory'),
                  buildCard("Mall", Icons.shop, AppColor.primaryColor,
                      'mallcategory'),
                  buildCard("All", Icons.more_horiz, AppColor.primaryColor,
                      'allcategory'),
                ],
              ),
            ),
            const SizedBox(height: 30.0),

            // Carousel Slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Carousel Ad",
                style: AppWidget.subTitle(),
              ),
            ),
            const SizedBox(height: 10.0),
            CarouselSlider(
              items: [
                buildCarouselItem("assets/images/food1.jpeg"),
                buildCarouselItem("assets/images/food2.jpeg"),
                buildCarouselItem("assets/images/dfd.png"),
              ],
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                autoPlayInterval: const Duration(seconds: 3),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            //Feature Restaurants
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Feature Restaurants",
                    style: AppWidget.subTitle(),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: featureRestaurantsList.length > 5
                        ? 6
                        : featureRestaurantsList.length,
                    itemBuilder: (context, index) {
                      if (index == 5) {
                        return GestureDetector(
                          onTap: () {
                            // Go to Feature Restaurants Page
                            Get.snackbar(
                                "Success", "Go to Feature Restaurants Page");
                          },
                          child: const Center(
                            child: Icon(Icons.arrow_forward,
                                size: 50, color: Colors.black),
                          ),
                        );
                      }

                      final restaurant = featureRestaurantsList[index];
                      return Card(
                        color: Colors.white,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: SizedBox(
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.restaurant,
                                  size: 50, color: Colors.orangeAccent),
                              const SizedBox(height: 8),
                              Text(
                                restaurant['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                restaurant['restaurant_type']!,
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Your Favourite Cuisine",
                    style: AppWidget.subTitle(),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(const SeeMorePage());
                        },
                        child: const Text(
                          "see more",
                          style: TextStyle(color: AppColor.primaryColor),
                        )),
                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            // Scrollable Image Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 100.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          "assets/images/food1.jpeg",
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 30.0),

            // Grid View
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Explore Categories",
                style: AppWidget.subTitle(),
              ),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Category ${index + 1}",
                        style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to Build Card
  Widget buildCard(String title, IconData icon, Color color, String route) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Column(
        children: [
          // Card with Centered Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.yellow[50],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Icon(icon, color: color, size: 30),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  // Widget to Build Carousel Slider Item
  Widget buildCarouselItem(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}

// See More Page Implementation
class SeeMorePage extends StatelessWidget {
  const SeeMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Images",
          style: AppWidget.appBarTextStyle(),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: 20, // Replace with the total number of images
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "assets/images/food1.jpeg", // Replace with your image path
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
