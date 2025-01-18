import 'dart:convert';

import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/models/user_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';

import '../repositories/handle_error.dart';

Future<UserModel> handleRequestAuth(String endpoint, Map<String, dynamic> requestBody) async {
    try {
      // API call
      final response = await ApiService().request(
        endpoint,
        method: "POST",
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Parse user data from response
        final user = UserModel.fromJson(responseData);
        final accessToken = responseData['access_token'];

        // Debugging
        debugPrint("User logged in: $user");
        debugPrint("Access token: $accessToken");

        return user;
      } else {
        // Handle non-200 responses
        var errorMessage = handleError(response.statusCode);
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: errorMessage ?? "An unexpected error occurred",
          backgroundColor: Colors.red,
        );
        throw Exception("Request failed with status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint("Error during request: $e");
      debugPrint(stackTrace.toString());

      SnackbarHelper.showSnackbar(
        title: "Error",
        message: ApiMessages.unexpectedError,
        backgroundColor: Colors.red,
      );
      throw Exception("An unexpected error occurred");
    }
  }