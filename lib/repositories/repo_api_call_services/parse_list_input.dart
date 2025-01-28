class ParseListInput<T> {
  final Map<String, dynamic> responseMap;  // Map containing a List
  final T Function(Map<String, dynamic>) fromJson; // Function to convert a Map to an object

  ParseListInput({
    required this.responseMap,
    required this.fromJson,
  });
}
