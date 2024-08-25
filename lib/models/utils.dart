
import 'package:app_structure/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

String hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
}

Future<void> signUp(String name, String email, String password, String phoneNumber) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Hash the password before storing it
  String hashedPassword = hashPassword(password);

  // Save all user details
  await prefs.setString('user_name', name);
  await prefs.setString('user_email', email);
  await prefs.setString('user_password', hashedPassword);
  await prefs.setString('user_phone', phoneNumber);

}



Future<bool> signIn(BuildContext context, String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve stored email, password, and name
  String? storedEmail = prefs.getString('user_email');
  String? storedPassword = prefs.getString('user_password');
  String? storedName = prefs.getString('user_name');

  // Hash the input password for comparison
  String hashedInputPassword = hashPassword(password);

  // Validate credentials
  if (storedEmail == email && storedPassword == hashedInputPassword) {
    
    // Update the UserProvider with the actual user data
    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false).signIn(storedName!, email);

    return true;
  } else {
    return false;
  }
}

