import 'package:flutter/material.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';

class JoinTeamDialog extends StatelessWidget {
  final String teamName;
  final VoidCallback onRequestJoin;

  const JoinTeamDialog({
    Key? key,
    required this.teamName,
    required this.onRequestJoin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirmation',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: RichText(
        text: TextSpan(
          text: 'Veuillez confirmer que vous voulez rejoindre ',
          style: TextStyle(
            color: Colors.grey[700],
          ),
          children: <TextSpan>[
            TextSpan(
              text: '"$teamName"',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            TextSpan(
              text: '?',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ],
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
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomElevatedButton(
          label: 'Rejoindre',
          onPressed: () {
            onRequestJoin();
            Navigator.pop(context);
          },
          color: Theme.of(context).primaryColor,
          width: 150,
        ),
      ],
    );
  }
}
