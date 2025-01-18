import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:flutter/material.dart';

void handleErrorSnackbar(String errorMessage) {
  SnackbarHelper.showSnackbar(
    title: "Error",
    message: errorMessage,
    backgroundColor: Colors.red,
  );
}