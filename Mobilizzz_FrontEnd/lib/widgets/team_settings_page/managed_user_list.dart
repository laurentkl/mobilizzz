import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/widgets/team_settings_page/managed_user_row.dart';

class ManagedUsersList extends StatelessWidget {
  const ManagedUsersList({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    // Combine users and pending user requests into a single list
    List<User> combinedUsers = [];
    if (team.pendingUserRequests != null) {
      combinedUsers.addAll(team.pendingUserRequests!);
    }

    if (team.users != null) {
      combinedUsers.addAll(team.users!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Member List',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: combinedUsers.length,
            itemBuilder: (context, index) {
              var user = combinedUsers[index];
              bool isPending =
                  team.pendingUserRequests?.contains(user) ?? false;
              return ManagedUserRow(
                user: user,
                isPending: isPending,
                // onAccept: () {
                //   // TODO: Implement accept functionality
                // },
                // onReject: () {
                //   // TODO: Implement reject functionality
                // },
              );
            },
          ),
        ),
      ],
    );
  }
}
