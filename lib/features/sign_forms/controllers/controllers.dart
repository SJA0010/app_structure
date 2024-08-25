import 'package:flutter/material.dart';

class AppTextControllers {
  AppTextControllers._(); // Private constructor to prevent instantiation

  // Singleton instance
  static final AppTextControllers instance = AppTextControllers._();

  // Example TextEditingControllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Method to dispose all controllers
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
   
  }
}