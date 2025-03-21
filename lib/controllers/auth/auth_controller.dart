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
      if(user.accessToken!.isEmpty){
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: ApiMessages.invalidLogin,
          backgroundColor: Colors.red,
        );
      }else{
        handleSuccessAuth(user, Messages.loginSuccess);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      UserModel user = await authService.register(name, email, password);
      if(user.accessToken!.isEmpty){
        SnackbarHelper.showSnackbar(
          title: "Error",
          message: ApiMessages.failRegister,
          backgroundColor: Colors.red,
        );
      }else{
        handleSuccessAuth(user, Messages.registerSuccess);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
