
import 'package:flutter/material.dart';

class PopularRestaurantsPage extends StatelessWidget {
  const PopularRestaurantsPage({super.key});

  final List<Map<String, String>> restaurants = const [
    {
      'name': 'The Gourmet Spot',
      'location': 'Downtown Avenue',
      'description': 'A fine dining restaurant offering global cuisines.',
    },
    {
      'name': 'Pizza Paradise',
      'location': 'Main Street',
      'description': 'Delicious wood-fired pizzas with fresh ingredients.',
    },
    {
      'name': 'Sushi Haven',
      'location': 'Ocean Drive',
      'description': 'Fresh and authentic Japanese sushi.',
    },
    {
      'name': 'Burger Bliss',
      'location': 'City Center',
      'description': 'Juicy burgers and crispy fries.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Restaurants'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(restaurant['name']!),
              subtitle: Text(restaurant['location']!),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RestaurantDetailsPage(restaurant: restaurant),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class RestaurantDetailsPage extends StatelessWidget {
  final Map<String, String> restaurant;

  const RestaurantDetailsPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant['name']!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  restaurant['location']!,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              restaurant['description']!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
