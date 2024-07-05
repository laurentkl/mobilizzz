import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class LoginBottomButtons extends StatelessWidget {
  const LoginBottomButtons({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            if (context.mounted) context.go('/signup');
          },
          child: const AutoSizeText(
            "Vous n'avez pas de compte ? Inscrivez-vous ici",
            style: TextStyle(color: Colors.blue),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
