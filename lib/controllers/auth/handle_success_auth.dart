import 'package:dailyfairdeal/models/user/user_model.dart';
import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void handleSuccessAuth(UserModel user, String successMessage) {
  if (user.accessToken!.isNotEmpty && user.name.isNotEmpty) {
    debugPrint("User Name is ${user.name}");
    debugPrint("User Role Name is ${user.role}");
    saveToken(user.accessToken!); //save token
    saveUserId(user.id); //save user id
    saveUserName(user.name); //save user name
    saveUserRole(user.role!); //save user role
    SnackbarHelper.showSnackbar(
      title: "Success",
      message: successMessage,
    );
    Get.off(() => MainScreen());
  } else {
    SnackbarHelper.showSnackbar(
      title: "Error",
      message: user.message!,
      backgroundColor: Colors.red,
    );
  }
}