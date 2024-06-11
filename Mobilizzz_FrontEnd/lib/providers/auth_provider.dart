import 'package:flutter/material.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<void> signIn(String email, String password) async {
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        _user = user;
        notifyListeners();
      } 
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(
      String email, String password, String firstName, String lastName) async {
    try {
      final user =
          await _authService.signUp(email, password, firstName, lastName);
      if (user != null) {
        _user = user;
        notifyListeners();
      } 
    } catch (error) {
      rethrow;
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
