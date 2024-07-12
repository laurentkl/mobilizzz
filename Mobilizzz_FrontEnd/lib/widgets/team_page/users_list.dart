import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/widgets/team_page/user_row.dart';

class UsersList extends StatelessWidget {
  final List<User> users;
  final int teamId;

  const UsersList({super.key, required this.users, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return UserRow(user: user, teamId: teamId);
        },
      ),
    );
  }
}
