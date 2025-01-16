import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class ApiService {
  final http.Client _client;
  final String _baseUrl;

  // Private constructor
  ApiService._internal()
      : _client = http.Client(),
        _baseUrl = AppUrl.baseUrl;

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor for singleton
  factory ApiService() {
    return _instance;
  }

  /// Generic Request Method
  Future<http.Response> request(
    String endpoint, {
    String method = "GET",
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse(endpoint.startsWith('http') ? endpoint : "$_baseUrl/$endpoint");
    final token = await getToken(); // Fetch token from secure storage

    // Default headers with token
    final defaultHeaders = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    // Merge default and custom headers
    final requestHeaders = {...defaultHeaders, ...?headers};

    try {
      late http.Response response;

      // HTTP method handling
      switch (method.toUpperCase()) {
        case "POST":
          response = await _client.post(
            uri,
            headers: requestHeaders,
            body: jsonEncode(body),
          );
          break;
        case "PUT":
          response = await _client.put(
            uri,
            headers: requestHeaders,
            body: jsonEncode(body),
          );
          break;
        case "DELETE":
          response = await _client.delete(uri, headers: requestHeaders);
          break;
        case "GET":
        default:
          response = await _client.get(uri, headers: requestHeaders);
      }

      // Handle response status codes
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        return _handleError(response);
      }
    } catch (e) {
      throw Exception("Request failed: $e");
    }
  }

  /// Handle API Errors
  http.Response _handleError(http.Response response) {
    final statusCode = response.statusCode;

    switch (statusCode) {
      case 401:
        throw Exception(ApiMessages.unauthorized);
      case 500:
        throw Exception(ApiMessages.serverError);
      case 204:
        throw Exception(ApiMessages.noData);
      default:
        throw Exception(
            "${ApiMessages.failedToLoad} (Status Code: $statusCode)");
    }
  }
}
