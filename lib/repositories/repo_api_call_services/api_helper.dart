import 'package:dailyfairdeal/repositories/repo_api_call_services/handle_response.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/log_error.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/parse_list.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/parse_list_input.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/sanitize_headers.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/validate_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:dailyfairdeal/services/api_service.dart';

class ApiHelper {
  static final _client = ApiService(); // Persistent HTTP client
  static const _timeoutDuration = Duration(seconds: 10); // Request timeout

  /// Makes an API request and returns the parsed response.
  static Future<T> request<T>({
    required String endpoint,
    required String method,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      ValidateEndPoint.validateEndpoint(
          endpoint); // Validate endpoint for security
      final sanitizedHeaders = SanitizeHeaders.sanitizeHeaders(headers);

      // Make the API request with timeout
      final response = await _client
          .request(
        endpoint,
        method: method,
        body: body,
        headers: sanitizedHeaders,
      )
          .timeout(_timeoutDuration, onTimeout: () {
        throw Exception("Request timed out after $_timeoutDuration seconds.");
      });

      // Handle and parse response
      return HandleResponse.handleResponse<T>(
          response.body, response.statusCode, fromJson);
    } catch (e, stackTrace) {
      LogError.logError("API Request Error", e, stackTrace);
      throw Exception("An unexpected error occurred: $e");
    }
  }

  /// Fetches a list of items from the API with caching and performance optimization.
  static Future<List<T>> fetchList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      // Fetch the response
      final response = await request<Map<String, dynamic>>(
        endpoint: endpoint,
        method: "GET",
      );

      // Prepare data for isolate
      final input = ParseListInput<T>(
        responseMap: response,
        fromJson: fromJson,
      );

      // Offload JSON parsing to a separate thread
      return await compute(parseList, input);
    } catch (e, stackTrace) {
      LogError.logError("Error fetching list", e, stackTrace);
      throw Exception("Failed to fetch data");
    }
  }
}
