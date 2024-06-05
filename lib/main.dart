import 'package:flutter/material.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/widgets/users_list.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                // Centered title with styling
                const Center(
                  child: Text(
                    "Team mobilizzz",
                    style: TextStyle(
                      fontSize: 24.0, // Set desired font size
                      fontWeight: FontWeight.bold, // Add boldness for a stronger look
                      color: Colors.teal, // Use a custom color for emphasis
                    ),
                  ),
                ),
                // Use Consumer to access AuthProvider
                Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    final user = authProvider.user;

                    // Check if user is null
                    if (user == null) {
                      return const Center(
                        child: Text('No user logged in.'),
                      );
                    }

                    // Check if user has teams
                    if (user.teams.isEmpty) {
                      return const Center(
                        child: Text('User is not part of any teams.'),
                      );
                    }

                    // Display the list of teams
                    return Expanded(
                      child: ListView.builder(
                        itemCount: user.teams.length,
                        itemBuilder: (context, index) {
                          final team = user.teams[index];
                          return ListTile(
                            title: Text(team.name),
                          );
                        },
                      ),
                    );
                  },
                ),
                const Expanded(child: UsersList()), // Rest of the page layout
              ],
            ),
            Positioned( // Position button at bottom right
              bottom: 20.0, // Adjust for spacing from bottom
              right: 20.0,  // Adjust for spacing from right
              child: FloatingActionButton(
                heroTag: "team-btn-insert",
                onPressed: () {
                  // Handle button press (add your functionality here)
                }, // Replace with desired icon
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add), // Set button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
