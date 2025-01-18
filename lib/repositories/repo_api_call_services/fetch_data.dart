import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/log_error.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/parse_list.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/parse_list_input.dart';
import 'package:flutter/foundation.dart';

class FetchData{
   static Future<List<T>> fetchList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      // Fetch the response
      final response = await ApiHelper.request<List<dynamic>>(
        endpoint: endpoint,
        method: "GET",
      );

      // Prepare data for isolate
      final input = ParseListInput<T>(
        responseList: response,
        fromJson: fromJson,
      );

      // Offload JSON parsing to a separate thread
      return await compute(parseList, input);
    } catch (e, stackTrace) {
      LogError.logError("Error fetching list", e, stackTrace);
      throw Exception("Failed to fetch data");
    }
  }

  static Future<Map<String, dynamic>> fetchMap({
    required String endpoint,
  }) async {
    try {
      // Fetch the response as a map
      final response = await ApiHelper.request<Map<String, dynamic>>(
        endpoint: endpoint,
        method: "GET",
      );

      return response;
    } catch (e, stackTrace) {
      LogError.logError("Error fetching map", e, stackTrace);
      throw Exception("Failed to fetch data");
    }
  }
}