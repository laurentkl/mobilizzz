import 'package:flutter/material.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';

class GenericConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final VoidCallback onConfirm;

  const GenericConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          color: Colors.grey[700],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      actionsPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Annuler',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomElevatedButton(
          label: confirmText,
          onPressed: onConfirm,
          color: Theme.of(context).primaryColor,
          width: 150,
        ),
      ],
    );
  }
}
