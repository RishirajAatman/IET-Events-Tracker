import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _userRole = 'student'; // Default role

  String get userRole => _userRole;

  void setUserRole(String role) {
    _userRole = role;
    notifyListeners();
  }
}
