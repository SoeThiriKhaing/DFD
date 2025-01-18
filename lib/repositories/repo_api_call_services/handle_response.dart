import 'dart:convert';

class HandleResponse{
  static T handleResponse<T>(
    String responseBody,
    int statusCode,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    if (statusCode >= 200 && statusCode < 300) {
      final responseData = jsonDecode(responseBody);

      if (fromJson != null) {
        if (responseData is Map<String, dynamic>) {
          return fromJson(responseData);
        } else {
          throw Exception("Expected an object but received: ${responseData.runtimeType}");
        }
      }

      return responseData as T;
    } else {
      throw Exception("Request failed with status code: $statusCode");
    }
  }
}