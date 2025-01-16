import 'package:dailyfairdeal/config/messages.dart';

class Validators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationMessages.passwordRequired;
    }

    if (value.length < 6) {
      return ValidationMessages.passwordMinLength;
    }

    final letterPattern = RegExp(r'[a-zA-Z]');
    if (!letterPattern.hasMatch(value)) {
      return ValidationMessages.passwordDigitRequired;
    }

    final digitPattern = RegExp(r'[0-9]');
    if (!digitPattern.hasMatch(value)) {
      return ValidationMessages.passwordDigitRequired;
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationMessages.emailRequired;
    }

    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailPattern.hasMatch(value)) {
      return ValidationMessages.emailInvalid;
    }

    if (!value.endsWith('@gmail.com')) {
      return ValidationMessages.emailDomainInvalid;
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationMessages.nameRequired;
    }
    return null;
  }

  static String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationMessages.textFieldRequired;
    }
    return null;
  }
}
