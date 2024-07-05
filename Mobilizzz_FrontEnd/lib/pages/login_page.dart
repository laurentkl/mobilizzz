import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/widgets/generic/auth_header.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';
import 'package:mobilizzz/widgets/generic/custom_textfield.dart';
import 'package:mobilizzz/widgets/login_page/login_bottom_buttons.dart';
import 'package:mobilizzz/widgets/login_page/login_form.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController =
      TextEditingController(text: "klein@test.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "password");

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AuthHeader(),
              LoginForm(
                  emailController: _emailController,
                  passwordController: _passwordController),
              LoginBottomButtons(
                  emailController: _emailController,
                  passwordController: _passwordController),
            ],
          ),
        ),
      ),
    );
  }
}
