import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Assuming you have a User model defined somewhere
class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}

class UserProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // Method to load the current user from SharedPreferences
  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserString = prefs.getString('currentUser');
    if (currentUserString != null) {
      _currentUser = User.fromJson(json.decode(currentUserString));
      notifyListeners();
    }
  }

  // Method to sign in a user
  Future<bool> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString('users');

    if (usersString != null) {
      final users = (json.decode(usersString) as List)
          .map((data) => User.fromJson(data))
          .toList();

      try {
        final user = users.firstWhere(
            (user) => user.email == email && user.password == password);

        _currentUser = user;

        // Save current user to SharedPreferences (for persistence)
        prefs.setString('currentUser', json.encode(user.toJson()));
        notifyListeners();
        return true;
      } catch (e) {
        // User not found or password is incorrect
        return false;
      }
    }
    return false; // No users found
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    notifyListeners();
  }

  // Method to register a new user (if needed)
  // Future<void> registerUser(String name, String email, String password) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final usersString = prefs.getString('users');
  //   List<User> users = [];

  //   if (usersString != null) {
  //     users = (json.decode(usersString) as List)
  //         .map((data) => User.fromJson(data))
  //         .toList();

  //   }

  //   final newUser = User(name: name, email: email, password: password);
  //   users.add(newUser);

  //   // Save the updated list of users to SharedPreferences
  //   prefs.setString(
  //       'users', json.encode(users.map((u) => u.toJson()).toList()));
  // }

  Future<void> registerUser(
    String name,
    String email,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString('users');
    List<User> users = [];

    if (usersString != null) {
      users = (json.decode(usersString) as List)
          .map((data) => User.fromJson(data))
          .toList();
    }

    final newUser = User(
      name: name,
      email: email,
      password: password,
    );
    users.add(newUser);

    prefs.setString(
        'users', json.encode(users.map((u) => u.toJson()).toList()));
  }

  // Get all users who have signed up
  Future<List<User>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString('users');

    if (usersString != null) {
      final users = (json.decode(usersString) as List)
          .map((data) => User.fromJson(data))
          .toList();
      return users;
    }
    return []; // Return an empty list if no users are found
  }
  
}
