import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class SignUpBottomButtons extends StatelessWidget {
  const SignUpBottomButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            if (context.mounted) context.go('/login');
          },
          child: const AutoSizeText(
            'Vous possédez déja un compte ? Connectez-vous ici.',
            style: TextStyle(color: Colors.blue),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
