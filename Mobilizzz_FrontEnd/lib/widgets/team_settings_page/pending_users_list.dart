import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';

class PendingUsersList extends StatelessWidget {
  const PendingUsersList({
    Key? key,
    required this.team,
    required this.approveJoinTeam, // Declare callback function parameter
  }) : super(key: key);

  final Team team;
  final Function(User, bool) approveJoinTeam; // Define callback function type

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: team.pendingUserRequests?.length ?? 0,
      itemBuilder: (context, index) {
        if (team.pendingUserRequests == null) {
          return const ListTile(
            title: Text('No pending user requests'),
          );
        } else {
          final user = team.pendingUserRequests![index];
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(user.email),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => approveJoinTeam(user, true), // Call callback
                  icon: const Icon(Icons.check),
                  color: Colors.green,
                ),
                IconButton(
                  onPressed: () =>
                      approveJoinTeam(user, false), // Call callback
                  icon: const Icon(Icons.close),
                  color: Colors.red,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
