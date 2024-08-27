import 'package:app_structure/scr/features/firebase_sign/pages/sign_in.dart';
import 'package:app_structure/scr/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SignUpProvider extends ChangeNotifier {
  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text Editing Controllers for form inputs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // A flag to indicate if a sign-up process is ongoing
  bool _isLoading = false;

  // Getter for isLoading flag
  bool get isLoading => _isLoading;

  // Function to create a new user
  Future<void> signUpUser(BuildContext context) async {
    _setLoading(true);

    try {
      // Create a unique user ID
      var uid = Uuid();
      String userId = uid.v4();

      // Create a new UserModel object with the form data
      UserModel userModel = UserModel(
        userName: nameController.text,
        password: passwordController.text,
        email: emailController.text,
        phone: phoneController.text,
        userid: userId,
      );

      // Store the user data in Firestore
      await _firestore
          .collection("AllUsers")
          .doc(userId)
          .set(userModel.toMap());

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Account Successfully Created'),
          content: const Text('Go to login page'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FirebaseSignIn(),
                ),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Handle errors if any
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    } finally {
      _setLoading(false);
    }
  }

  // Function to set the loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
