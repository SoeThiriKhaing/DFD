import 'package:flutter/material.dart';

class RestaurantList extends StatelessWidget {
  final Future<List<dynamic>> listFuture;
  final String categoryType;

  const RestaurantList({
    super.key,
    required this.listFuture,
    required this.categoryType,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: listFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return Center(child: Text('No $categoryType available'));
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              color: Colors.white,
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: Text(item['name'] ?? 'Unnamed $categoryType'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['restaurant_type'] ?? 'No type available'),
                    if (categoryType == 'Featured Restaurants') ...[
                      Text(item['open_time'] ?? 'No time available'),
                      Text(item['close_time'] ?? 'No time available'),
                      Text(item['City_Name'] ?? 'No location available'),
                    ],
                  ],
                ),
                leading: item['image'] != null
                    ? Image.network(item['image'],
                        width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.restaurant),
                onTap: () {
                  // Handle navigation to item details or other actions
                },
              ),
            );
          },
        );
      },
    );
  }
}
