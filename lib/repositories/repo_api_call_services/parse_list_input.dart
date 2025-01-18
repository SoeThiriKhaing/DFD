class ParseListInput<T> {
  final List<dynamic> responseList;
  final T Function(Map<String, dynamic>) fromJson;

  ParseListInput({
    required this.responseList,
    required this.fromJson,
  });
}