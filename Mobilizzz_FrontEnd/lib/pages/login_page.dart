import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController =
      TextEditingController(text: "klein@test.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "password");

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('LogDin'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                try {
                  await authProvider.signIn(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                  // Future<void> _saveUser() async {
                  //   final prefs = await SharedPreferencesStorePlatform.instance;
                  //   prefs.setValue("String",'user', jsonEncode("hello world"));
                  // }

                  if (context.mounted) context.go('/bottomnav');
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error.toString())),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // Navigate to LoginPage
                if (context.mounted) context.go('/signup');
              },
              child: const Text(
                "Don't have an account yet ? Sign up here",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
