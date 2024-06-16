import 'package:flutter/material.dart';
import 'package:mobilizzz/models/user_model.dart';

class UsersList extends StatelessWidget {
  final List<User> users;
  final int teamId; 

  const UsersList({super.key, required this.users, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber, 
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      user.firstName ?? "",
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  Text(
                    '${user.getTotalDistanceByTeam(teamId).toStringAsFixed(1)} km',
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}