import 'dart:convert';

import 'package:mobilizzz/models/login_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<User?> signIn(String email, String password) async {
    try {
      const url = '${AppConstants.apiUrl}/Auth/login';
      final uri = Uri.parse(url);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(Login(email: email, password: password).toJson());

      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final userJson = json['user'];
        final token = json['token'];
        // Save token for future API requests (optional)
        // authService.setToken(token);
        return User.fromJson(userJson);
      } else if (response.statusCode == 401) {
        throw jsonDecode(response.body)['message'];
      } else {
        throw 'Failed to sign in: ${response.statusCode}';
      }
    } catch (error) {
      throw Exception('Error signing in: $error');
    }
  }

  Future<User?> signUp(String userName, String firstName, String lastName,
      String email, String password, int teamCode) async {
    try {
      const url = '${AppConstants.apiUrl}/Auth/SignUp';
      final uri = Uri.parse(url);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'teamCode': teamCode,
      });

      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final userJson = json['user'];
        final token = json['token'];
        // Save token for future API requests (optional)
        // authService.setToken(token);
        return User.fromJson(userJson);
      } else if (response.statusCode == 409) {
        throw jsonDecode(response.body)['message'];
      } else {
        throw 'Failed to sign up: ${response.statusCode}';
      }
    } catch (error) {
      throw Exception('Error signing up: $error');
    }
  }

  Future<User?> getCurrentUser() async {
    const url = '${AppConstants.apiUrl}/User/Get/1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    }
    return null;
  }
}
