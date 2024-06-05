import 'package:flutter/material.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  // Method to sign in user
  Future<void> signIn(String email, String password) async {
    // Call the sign-in method from the AuthService
    final user = await _authService.getCurrentUser();
    if (user != null) {
      _user = user;
    }
    notifyListeners();
  }

  // Method to sign out user
  void signOut() {
    _authService.signOut();
    _user = null;
    notifyListeners();
  }
}