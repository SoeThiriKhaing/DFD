import 'package:flutter/material.dart';

class BaseController<T> {
  final Future<List<T>> Function() fetchItems;

  BaseController({required this.fetchItems});

  Future<List<Map<String, String>>> loadItems(
    Map<String, String> Function(T item) transform,
  ) async {
    try {
      final items = await fetchItems();
      debugPrint('Fetched items in BaseController: $items'); // Debug print
      return items.map(transform).toList();
    } catch (e) {
      debugPrint("Error in BaseController: $e");
      throw Exception("Failed to load items");
    }
  }
}
