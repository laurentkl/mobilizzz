import 'dart:convert';

import 'package:mobilizzz/models/login_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
Future<User?> signIn(String email, String password) async {
  try {
    const url = 'http://10.0.10.55:5169/Auth/login';
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
      // Assuming your response contains both user and token
      final userJson = json['user'];
      final token = json['token'];
      // Save token for future API requests (optional)
      // Set token in your AuthService or somewhere accessible
      // authService.setToken(token);
      return User.fromJson(userJson);
    } else {
      // If the request was not successful, handle the error
      // You might want to return different types of errors based on status code
      print('Failed to sign in: ${response.statusCode}');
      // For simplicity, we return null in case of any error
      return null;
    }
  } catch (error) {
    // If an exception occurs during the request, handle it
    print('Error signing in: $error');
    // Return null if there is an error
    return null;
  }
}

Future<User?> signUp(String firstName, String lastName, String email, String password) async {
  try {
    const url = 'http://10.0.10.55:5169/Auth/signup';
    final uri = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    });

    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // Assuming your response contains both user and token
      final userJson = json['user'];
      final token = json['token'];
      // Save token for future API requests (optional)
      // Set token in your AuthService or somewhere accessible
      // authService.setToken(token);
      return User.fromJson(userJson);
    } else {
      // If the request was not successful, handle the error
      // You might want to return different types of errors based on status code
      print('Failed to sign up: ${response.statusCode}');
      // For simplicity, we return null in case of any error
      return null;
    }
  } catch (error) {
    // If an exception occurs during the request, handle it
    print('Error signing up: $error');
    // Return null if there is an error
    return null;
  }
}


  Future<User?> getCurrentUser() async {
    const url = 'http://10.0.10.55:5169/User/Get/1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body); 
      return User.fromJson(json);
    }
    return null;
  }
}
