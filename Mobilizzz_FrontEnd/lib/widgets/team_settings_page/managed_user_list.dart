import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/widgets/team_settings_page/managed_user_row.dart';

class ManagedUsersList extends StatelessWidget {
  final Team team;
  final Function(User, bool) approveCallback; // Callback function

  const ManagedUsersList({
    Key? key,
    required this.team,
    required this.approveCallback, // Initialize the callback function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<User> combinedUsers = [];
    if (team.pendingUserRequests != null) {
      combinedUsers.addAll(team.pendingUserRequests!);
    }

    if (team.users != null) {
      combinedUsers.addAll(team.users!);
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Liste des membres',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryColor),
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
                onAccept: () {
                  approveCallback(user, true); // Invoke approve callback
                },
                onReject: () {
                  approveCallback(user, false); // Invoke reject callback
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
