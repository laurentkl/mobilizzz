import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController(text: "klein@test.com");
  final TextEditingController _passwordController = TextEditingController(text: "password");

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
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
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                final signInSuccess = await authProvider.signIn(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
                if (signInSuccess) {
                  // If sign-in is successful, navigate to another route
                  if(context.mounted) context.go('/bottomnav');
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
