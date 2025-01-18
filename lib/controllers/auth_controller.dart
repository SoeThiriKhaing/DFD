import 'package:dailyfairdeal/config/messages.dart';
import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthController {
  final AuthService authService;

  AuthController({required this.authService});

  final apiService = ApiService();

  Future<void> login(String email, String password) async {
    try {
      final token = await authService.login(email, password);
      if (token != null) {
        await saveToken(token as String);
        SnackbarHelper.showSnackbar(
          title: "Success",
          message: Messages.loginSuccess,
        );
        Get.off(() => MainScreen());
      }
    } catch (e) {
      SnackbarHelper.showSnackbar(
        title: "Error",
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      final token = await authService.register(name, email, password);
      if (token != null) {
        SnackbarHelper.showSnackbar(
          title: "Success",
          message: Messages.registerSuccess,
        );
        // Navigate to the login page or save the token
      }
    } catch (e) {
      SnackbarHelper.showSnackbar(
        title: "Error",
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
