import 'package:flutter/material.dart';
import 'package:mobilizzz/providers/user_provider.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:provider/provider.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
            final users = userProvider.users;
            return ListView.builder(
              // Show only the first 5 elements
              itemCount: users?.length,
              itemBuilder: (context, index) {
                final user = users?[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.tealAccent[100], // Single color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Less space
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            user?.firstName ?? "",
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        Text(
                          '${user?.getTotalDistanceByTeam(1).toStringAsFixed(1)} km',
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}
