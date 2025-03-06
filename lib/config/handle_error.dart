 import 'package:dailyfairdeal/config/api_messages.dart';

String? handleError(int statusCode) {
    switch (statusCode) {
      case 302:
        return ApiMessages.emailAlreadyUse;
      case 401:
        return ApiMessages.invalidToken;
      case 500:
        return ApiMessages.internalServerError;
      default:
        return ApiMessages.unknownError;
    }
  }