import 'package:flutter/material.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController(text: "user@example.com");
  final TextEditingController _passwordController = TextEditingController(text: "password");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Call the signIn method from the AuthProvider
                Provider.of<AuthProvider>(context, listen: false).signIn(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
