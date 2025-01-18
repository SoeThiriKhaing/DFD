import 'package:flutter/material.dart';
class LogError{
   static void logError(String context, Object error, StackTrace stackTrace) {
    debugPrint("$context: $error\nStackTrace: $stackTrace");
  }
}