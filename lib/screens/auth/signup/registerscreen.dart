import 'package:dailyfairdeal/controllers/auth_controller.dart';
import 'package:dailyfairdeal/repositories/auth_repository.dart';
import 'package:dailyfairdeal/services/auth_service.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/formfield.dart';
import 'package:dailyfairdeal/widget/logo_widget.dart';
import 'package:dailyfairdeal/widget/reusabel_button.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:dailyfairdeal/widget/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  final AuthController authController = Get.put(AuthController(authService: AuthService(authRepository: AuthRepository())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, right: 30.0, left: 30.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: logoWidget(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text("Name", style: AppWidget.formFieldLabelTextStyle()),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: Validators.validateName,
                      decoration: nameInputDecoration(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text("Email", style: AppWidget.formFieldLabelTextStyle()),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: Validators.validateEmail,
                      decoration: emailInputDecoration(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Password",
                      style: AppWidget.formFieldLabelTextStyle(),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: passwordController,
                      decoration: passwordInputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !isPasswordVisible,
                      validator: Validators.validatePassword,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text("Confirm Password",
                        style: AppWidget.formFieldLabelTextStyle()),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: confirmController,
                      validator: Validators.validatePassword,
                      decoration: confirmpasswordInputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !isPasswordVisible,
                    ),
                    const SizedBox(height: 30.0),
                    ReusableButton(
                      text: "Sign Up",
                      onPressed: () {
                       if (_formkey.currentState!.validate()) {
                          authController.register(nameController.text, emailController.text, passwordController.text);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/login");
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
