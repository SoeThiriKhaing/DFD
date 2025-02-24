import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/validate_endpoint.dart';

class ApiService {
  final http.Client _client;

  // Private constructor
  ApiService._internal() : _client = http.Client();

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
    ValidateEndPoint.validateEndpoint(endpoint); // Validate endpoint
    final uri = Uri.parse(endpoint);
    final token = await getToken();

    final defaultHeaders = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final requestHeaders = {...defaultHeaders, ...?headers};

    try {
      http.Response response;
      switch (method.toUpperCase()) {
        case "GET":
          response = await _client.get(uri, headers: requestHeaders);
          break;
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
        default:
          throw Exception("Unsupported HTTP method: $method");
      }

      debugPrint("Response (${response.statusCode}): ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint("Error during request: $e");
      debugPrint("StackTrace: $stackTrace");
      throw Exception("Request failed: $e");
    }
  }
}
