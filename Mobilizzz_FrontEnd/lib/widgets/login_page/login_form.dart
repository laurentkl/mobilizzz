import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';
import 'package:mobilizzz/widgets/generic/custom_textfield.dart';
import 'package:mobilizzz/widgets/login_page/login_bottom_buttons.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            controller: _emailController,
            label: "Email",
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: _passwordController,
            label: "Mot de passe",
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          CustomElevatedButton(
            onPressed: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              try {
                await authProvider.signIn(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
                if (context.mounted) context.go('/bottomnav');
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.toString())),
                );
              }
            },
            label: "Se connecter",
            color: AppConstants.primaryColor,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
