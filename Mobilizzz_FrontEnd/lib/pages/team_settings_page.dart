import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart'; // Import your Team model

class TeamSettingsPage extends StatefulWidget {
  final Team team;

  const TeamSettingsPage({Key? key, required this.team}) : super(key: key);

  @override
  _TeamSettingsPageState createState() => _TeamSettingsPageState();
}

class _TeamSettingsPageState extends State<TeamSettingsPage> {
  // Add state variables to store settings
  late String _teamName;
  late List<int> _adminIds;

  @override
  void initState() {
    super.initState();
    // Initialize settings with current values
    _teamName = widget.team.name;
    _adminIds = widget.team.adminIds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Settings Page'), // Change title here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Team Name'),
            TextFormField(
              initialValue: _teamName,
              onChanged: (value) {
                setState(() {
                  _teamName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Leader IDs'),
            TextFormField(
              initialValue: _adminIds.join(', '), // Convert list to string for display
              onChanged: (value) {
                setState(() {
                  // Split the string and convert it back to a list of ints
                  _adminIds = value.split(',').map((id) => int.parse(id.trim())).toList();
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save settings logic
                _saveSettings();
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSettings() {
    // Perform save logic here, e.g., update team name and leader ids
    // For demonstration, we're just printing the values
    print('Team Name: $_teamName');
    print('Leader IDs: $_adminIds');
    // You can call an API to save the updated settings to the backend
  }
}
