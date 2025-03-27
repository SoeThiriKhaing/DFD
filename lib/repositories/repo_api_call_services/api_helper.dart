import 'dart:convert';
import 'package:dailyfairdeal/repositories/repo_api_call_services/log_error.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/sanitize_headers.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/validate_endpoint.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_service.dart';

class ApiHelper {
  static final _client = ApiService(); // Persistent HTTP client
  static const _timeoutDuration = Duration(seconds: 1); // Request timeout

  /// Makes an API request and returns the parsed response.
  static Future<T> request<T>({
    required String endpoint,
    required String method,
    T Function(dynamic)? fromJson,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      ValidateEndPoint.validateEndpoint(
          endpoint); // Validate endpoint for security
      final sanitizedHeaders = SanitizeHeaders.sanitizeHeaders(headers);

      // Make the API request with timeout
      final response = await _client.request(
        endpoint,
        method: method,
        body: body,
        headers: sanitizedHeaders,
      ).timeout(_timeoutDuration, onTimeout: () {
        throw Exception("Request timed out after $_timeoutDuration seconds.");
      });

      final decodedResponse = jsonDecode(response.body);
      if (T == String) {
        // If the expected type is String, extract the 'message' field
        if (decodedResponse is Map<String, dynamic> && decodedResponse.containsKey('message')) {
          return decodedResponse['message'] as T;
        } else {
          throw Exception("Expected 'message' field in response, but not found.");
        }
      } else if (T == List<dynamic>) {
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('data')) {
          return decodedResponse['data'] as T;
        } else {
          return decodedResponse as T;
        }
      } else if (T == Map<String, dynamic>) {
        return decodedResponse as T;
      } else if (fromJson != null) {
        // Use fromJson for custom parsing
        return fromJson(decodedResponse);
      } else if (T == dynamic) {
        return decodedResponse as T;
      } else {
        throw Exception("Unsupported response type: $T");
      }

      // Handle and parse response
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
      final response = await request<List<dynamic>>(
        endpoint: endpoint,
        method: "GET",
      );

      // Convert the list of dynamic to a list of T
      return response
        .map((data) => fromJson(data as Map<String, dynamic>))
        .toList();
    } catch (e, stackTrace) {
      LogError.logError("Error fetching list", e, stackTrace);
      throw Exception("Failed to fetch data");
    }
  }
}
