class BaseController<T> {
  final Future<List<T>> Function() fetchItems;

  BaseController({required this.fetchItems});

  Future<List<Map<String, String>>> loadItems(
    Map<String, String> Function(T item) transform,
  ) async {
    try {
      final items = await fetchItems();
      print('Fetched items in BaseController: $items'); // Debug print
      return items.map(transform).toList();
    } catch (e) {
      print("Error in BaseController: $e");
      throw Exception("Failed to load items");
    }
  }
}
