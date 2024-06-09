import 'package:flutter/material.dart';

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
      title: Text('Join $teamName?'),
      content: Text('Do you want to request to join the team "$teamName"?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onRequestJoin();
            Navigator.pop(context);
          },
          child: Text('Request to Join'),
        ),
      ],
    );
  }
}
