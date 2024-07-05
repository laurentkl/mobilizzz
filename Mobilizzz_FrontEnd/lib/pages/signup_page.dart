import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/widgets/signup_page/signup_bottom_buttons.dart';
import 'package:mobilizzz/widgets/signup_page/signup_form.dart';
import 'package:mobilizzz/widgets/generic/auth_header.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _userNameController =
      TextEditingController(text: "Shady123");
  final TextEditingController _emailController =
      TextEditingController(text: "test@mail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "password");
  final TextEditingController _firstNameController =
      TextEditingController(text: "Laurent");
  final TextEditingController _lastNameController =
      TextEditingController(text: "Klein");
  final TextEditingController _teamCodeController =
      TextEditingController(text: "");

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const AuthHeader(),
              SignUpForm(
                  userNameController: _userNameController,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  teamCodeController: _teamCodeController),
              const SignUpBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
