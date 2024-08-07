import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  AuthProvider() {
    _loadUser(); // Load user data when the AuthProvider is initialized
  }

  set user(User? user) {
    _user = user;
    _clearUser();
    _saveUser(user!);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        _user = user;
        await _saveUser(user); // Save user data to SharedPreferences
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String userName, String email, String password,
      String firstName, String lastName, int teamCode) async {
    try {
      final user = await _authService.signUp(
          userName, email, password, firstName, lastName, teamCode);
      if (user != null) {
        _user = user;
        await _saveUser(user); // Save user data to SharedPreferences
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  void signOut() async {
    if (_user != null) {
      _user = null;
      await _clearUser(); // Clear user data from SharedPreferences
      notifyListeners();
    }
  }

  Future<bool> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      _user = User.fromJson(jsonDecode(userData));
      notifyListeners();
    }
    return (userData != null);
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user.toJson());
    await prefs.setString('user', userData);
  }

  Future<void> _clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
