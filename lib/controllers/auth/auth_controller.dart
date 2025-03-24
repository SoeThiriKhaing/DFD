import 'package:dailyfairdeal/controllers/auth/handle_success_auth.dart';
import 'package:dailyfairdeal/config/api_messages.dart';
import 'package:dailyfairdeal/config/messages.dart';
import 'package:dailyfairdeal/models/user/user_model.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import '../../services/auth/auth_service.dart';

class AuthController{
  final AuthService authService;

  AuthController({required this.authService});

  Future<void> login(String email, String password) async {
    try {
      UserModel user = await authService.login(email, password);
      
      if (user.accessToken != null && user.accessToken!.isNotEmpty) {
        handleSuccessAuth(user, Messages.loginSuccess);
      } else {
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: ApiMessages.invalidLogin,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      if (e.toString().contains("401")) {
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: "Invalid Email or Password",
          backgroundColor: Colors.red,
        );
      } else {
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: "Something went wrong. Please try again.",
          backgroundColor: Colors.red,
        );
      }
      debugPrint("Login Error: $e");
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      UserModel user = await authService.register(name, email, password);

      if (user.accessToken != null && user.accessToken!.isNotEmpty) {
        handleSuccessAuth(user, Messages.registerSuccess);
      } else {
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: ApiMessages.failRegister,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      if (e.toString().contains("401")) {
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: "Registration failed. Email may already be in use.",
          backgroundColor: Colors.red,
        );
      } else {
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: "Something went wrong. Please try again.",
          backgroundColor: Colors.red,
        );
      }
      debugPrint("Register Error: $e");
    }
  }

}
