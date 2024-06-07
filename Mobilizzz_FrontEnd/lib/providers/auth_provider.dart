import 'package:flutter/material.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/pages/login_page.dart';
import 'package:mobilizzz/pages/signup_page.dart';
import 'package:mobilizzz/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  // Method to sign in user
  Future<bool> signIn(String email, String password) async {
    // Call the sign-in method from the AuthService
    final user = await _authService.signIn(email, password);
    if (user != null) {
      _user = user;
      notifyListeners();
    }

    return user != null;
  }

  Future<void> signUp(
      String email, String password, String firstName, String lastName) async {
    try {
      final user =
          await _authService.signUp(email, password, firstName, lastName);
      if (user != null) {
        _user = user;
        notifyListeners();
      } else {
        print('Sign-up failed.');
      }
    } catch (error) {
      print('Error signing up: $error');
    }
  }

  // Method to sign out user
  void signOut() {
    if (_user != null) {
      _user = null;
      notifyListeners();
    }
  }
}
