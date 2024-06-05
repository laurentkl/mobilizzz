import 'package:flutter/material.dart';
import 'package:mobilizzz/widgets/users_list.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const Column(
              children: [
                // Centered title with styling
                Center(
                  child: Text(
                    "Team mobilizzz",
                    style: TextStyle(
                      fontSize: 24.0, // Set desired font size
                      fontWeight: FontWeight.bold, // Add boldness for a stronger look
                      color: Colors.teal, // Use a custom color for emphasis
                    ),
                  ),
                ),
                Expanded(child: UsersList()), // Rest of the page layout
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
