abstract class BaseController<T> {
  final Future<List<T>> Function() fetchItems;

  BaseController({required this.fetchItems});

  Future<List<Map<String, Object>>> loadItems(
    Map<String, Object> Function(T item) transform,
  ) async {
    try {
      final items = await fetchItems();
      return items.map(transform).toList();
    } catch (e) {
      print("Error in BaseController: $e");
      throw Exception("Failed to load items");
    }
  }
}
