import 'package:app_structure/scr/models/staticdata.dart';
import 'package:app_structure/scr/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  // List to store all users except the currently logged-in user
  List<UserModel> _allUsers = [];

  // Getter for allUsers list
  List<UserModel> get allUsers => _allUsers;

  // A flag to indicate if data is being fetched
  bool _isLoading = false;

  // Getter for isLoading flag
  bool get isLoading => _isLoading;

  // Function to fetch the list of users from Firestore
  Future<void> getUserList() async {
    _setLoading(true);
    _allUsers.clear();

    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection("AllUsers")
          .where("userid", isNotEqualTo: Staticdata.model!.userid)
          .get();

      for (var data in query.docs) {
        UserModel model =
            UserModel.fromMap(data.data() as Map<String, dynamic>);
        _allUsers.add(model);
      }
    } catch (e) {
      // Handle errors if any
      print('Error fetching users: $e');
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
