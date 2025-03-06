import 'package:dailyfairdeal/models/user/user_model.dart';
import 'package:dailyfairdeal/common_calls/handle_error_snackbar.dart';
import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void handleSuccessAuth(UserModel user, String successMessage) {
    debugPrint("Logged in user: ${user.name}, Token: ${user.accessToken}");
    if (user.accessToken.isNotEmpty) {
      saveToken(user.accessToken); //save token
      SnackbarHelper.showSnackbar(
        title: "Success",
        message: successMessage,
      );
      Get.off(() => MainScreen());
    } else {
      handleErrorSnackbar("Access token is empty. Failed to proceed.");
    }
  }