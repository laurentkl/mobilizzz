import 'dart:convert';

import 'package:mobilizzz/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Simulate user authentication
  Future<User?> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Simulate successful authentication
    if (email == 'user@example.com' && password == 'password') {
    } else {
      return null;
    }
    return null;
  }

  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 1));

    const url = 'http://10.0.10.55:5169/User/Get/1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body); 
      return User.fromJson(json);
    }
    return null;
  }

  // Sign out method
  void signOut() {
    // Perform sign-out logic here
  }
}
