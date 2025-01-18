import 'package:dailyfairdeal/repositories/repo_api_call_services/parse_list_input.dart';

List<T> parseList<T>(ParseListInput<T> input) {
  return input.responseList
      .map((item) => input.fromJson(item as Map<String, dynamic>))
      .toList();
}