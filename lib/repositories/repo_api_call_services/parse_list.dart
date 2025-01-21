import 'package:dailyfairdeal/repositories/repo_api_call_services/parse_list_input.dart';

List<T> parseList<T>(ParseListInput<T> input) {
  // Assuming the list is stored under the key 'data' in the map
  List<dynamic> responseList = input.responseMap['data'] ?? [];
  
  return responseList
      .map((item) => input.fromJson(item as Map<String, dynamic>))
      .toList();
}
