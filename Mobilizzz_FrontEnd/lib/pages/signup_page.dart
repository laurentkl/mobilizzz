import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'login_page.dart'; // Importez la page LoginPage ici

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 16.0),
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
              onPressed: () {
                // Call the signUp method from the AuthProvider
                Provider.of<AuthProvider>(context, listen: false).signUp(
                  _firstNameController.text.trim(),
                  _lastNameController.text.trim(),
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // Navigate to LoginPage
                  if(context.mounted) context.go('/bottomnav');
              },
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
