import 'package:flutter/material.dart';

bool isPasswordVisible = false;
InputDecoration nameInputDecoration() {
  return InputDecoration(
      hintText: "Enter Your Name",
      prefixIcon: const Icon(Icons.person),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ));
}

InputDecoration emailInputDecoration() {
  return InputDecoration(
    hintText: "Enter Your Email",
    prefixIcon: const Icon(Icons.email),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

InputDecoration passwordInputDecoration({required IconButton suffixIcon}) {
  return InputDecoration(
      hintText: "Enter Your Password",
      prefixIcon: const Icon(Icons.password),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      )); 
}

InputDecoration confirmpasswordInputDecoration({required IconButton suffixIcon}) {
  return InputDecoration(
    hintText: "Enter Confirm Password",
    prefixIcon: const Icon(Icons.password),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}