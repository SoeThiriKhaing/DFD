import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dailyfairdeal/services/secure_storage.dart';

class ApiService {
  final http.Client _client;

  // Private constructor
  ApiService._internal()
      : _client = http.Client();

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
    final uri = Uri.parse(endpoint);
    final token = await getToken();

    final defaultHeaders = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final requestHeaders = {...defaultHeaders, ...?headers};

    try {
      switch (method.toUpperCase()) {
        case "GET":
          debugPrint("GET request to $uri");
          return await _client.get(uri, headers: requestHeaders);

        case "POST":
        case "PUT":
        case "DELETE":
          debugPrint("Request Method: $method");
          debugPrint("Request Body: ${jsonEncode(body)}");
          if (body == null) {
            throw Exception("Body is required for $method request.");
          }
          return method == "POST"
              ? await _client.post(uri, headers: requestHeaders, body: jsonEncode(body))
              : await _client.put(uri, headers: requestHeaders, body: jsonEncode(body));

        default:
          throw Exception("Unsupported HTTP method: $method");
      }
    } catch (e, stackTrace) {
      debugPrint("Error during request: $e");
      debugPrint("StackTrace: $stackTrace");
      throw Exception("Request failed: $e");
    }
  }
}
