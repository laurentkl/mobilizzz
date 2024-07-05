import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';
import 'package:mobilizzz/widgets/generic/custom_textfield.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required this.userNameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.teamCodeController,
  }) : super(key: key);

  final TextEditingController userNameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController teamCodeController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: userNameController,
            label: 'Username',
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: firstNameController,
            label: 'First Name',
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: lastNameController,
            label: 'Last Name',
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: emailController,
            label: 'Email',
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: teamCodeController,
            label: 'Team Code (Optional)',
            obscureText: false,
          ),
          const SizedBox(height: 16.0),
          CustomElevatedButton(
            label: 'Sign Up',
            color: AppConstants.primaryColor,
            onPressed: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);

              try {
                await authProvider.signUp(
                  userNameController.text.trim(),
                  firstNameController.text.trim(),
                  lastNameController.text.trim(),
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  int.tryParse(teamCodeController.text.trim()) ?? 0,
                );
                if (context.mounted) context.go('/bottomnav');
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.toString())),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
