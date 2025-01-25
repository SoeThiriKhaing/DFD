class BaseController<T> {
  final Future<List<T>> Function() fetchItems;

  BaseController({required this.fetchItems});

  Future<List> loadItems(
    Map<String, String> Function(T item) transform,
  ) async {
    try {
      final items = await fetchItems();
      print('Fetched items: $items'); // Log the fetched items
      return items.map(transform).toList();
    } catch (e) {
      print("Error in BaseController: $e"); // Log error
      throw Exception("Failed to load items");
    }
  }
}
