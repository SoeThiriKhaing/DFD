import 'dart:convert';
import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:http/http.dart' as http;

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

  // Generic request method
  Future<http.Response> request(
    String endpoint, {
    String method = "GET",
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse("$_baseUrl$endpoint");
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

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else if (response.statusCode == 204) {
        throw Exception(ApiMessages.noData);
      } else if (response.statusCode == 401) {
        throw Exception(ApiMessages.unauthorized);
      } 
      else if (response.statusCode == 500) {
        throw Exception(ApiMessages.serverError);
      } else {
        throw Exception(ApiMessages.failedToLoad);
      }
    } catch (e) {
      throw Exception("Request failed: $e");
    }
    
    
  }

  get(String Function(String countryId) getDivisionById, {required String method}) {}
}
