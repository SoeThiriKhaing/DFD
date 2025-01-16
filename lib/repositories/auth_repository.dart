import 'dart:convert';
import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/models/user_model.dart';
import 'package:dailyfairdeal/repositories/handle_error.dart';
import 'package:dailyfairdeal/service/auth_api/login_res.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import '../interfaces/i_auth_repository.dart';
import '../util/appurl.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.request(
      AppUrl.loginEndpoint,method: "POST"
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['access_token'];
      } else if (response.statusCode == 400){
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: ApiMessages.invalidLogin,
          backgroundColor: Colors.red);
      }else{
        var errorMessage= handleError(response.statusCode);
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: errorMessage!,
          backgroundColor: Colors.red);
      }
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging
      debugPrint("Error during login: $e");
      debugPrint(stackTrace.toString());
      SnackbarHelper.showSnackbar(
        title: "Error",
        message: ApiMessages.unexpectedError,
        backgroundColor: Colors.red,
      );
    }
    return null;
  }

  @override
  Future<UserModel?> register(String name, String email, String password) async {
    try {
      final response = await apiService.request(AppUrl.registerEndpoint,method: "POST");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['access_token'];
      }  else if (response.statusCode == 400){
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: ApiMessages.invalidEmail,
          backgroundColor: Colors.red);
      }else{
        var errorMessage= handleError(response.statusCode);
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: errorMessage!,
          backgroundColor: Colors.red);
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
    return null;
  }
}
