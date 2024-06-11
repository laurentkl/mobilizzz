import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:provider/provider.dart'; // Import your Team model

class TeamSettingsPage extends StatefulWidget {
  final Team team;

  const TeamSettingsPage({Key? key, required this.team}) : super(key: key);

  @override
  _TeamSettingsPageState createState() => _TeamSettingsPageState();
}

class _TeamSettingsPageState extends State<TeamSettingsPage> {
  late String _teamName = "";
  late List<int>? _adminIds = [];
  late final List<User> _pendingUsers = []; 

  Future<void> _approveJoinTeam(User requestUser, bool isApproved) async {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await teamProvider.approveTeamRequest(authProvider.user!.id, widget.team.id!, requestUser.id, isApproved);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User request processed successfully')),
      );
      setState(() {
        _pendingUsers.remove(requestUser);
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to process user request')),
      );
    }
  }

  void _fetchTeamData() async {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await teamProvider.fetchTeamsForUser(authProvider.user!.id);
  }

  @override
  void initState() {
    super.initState();
    _fetchTeamData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Settings Page'),
      ),
      body: Consumer<TeamProvider>(
        builder: (context, teamProvider, child) {
          final updatedTeam = teamProvider.teamsForUser
              .firstWhere((team) => team.id == widget.team.id);
          return _buildSettingsForm(context, updatedTeam);
        },
      ),
    );
  }

  @override
  Widget _buildSettingsForm(BuildContext context, Team team) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Team Name'),
          TextFormField(
            initialValue: team.name,
            onChanged: (value) {
              setState(() {
                _teamName = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          Text('Leader IDs'),
          TextFormField(
            initialValue:
                team.adminIds.join(', '), // Convert list to string for display
            onChanged: (value) {
              setState(() {
                // Split the string and convert it back to a list of ints
                _adminIds =
                    value.split(',').map((id) => int.parse(id.trim())).toList();
              });
            },
          ),
          SizedBox(height: 16.0),
          Text('Pending User Requests'), // Display pending user requests
          ListView.builder(
            shrinkWrap: true,
            itemCount: team.pendingUserRequests?.length ??
                0, // Use null-aware operator to handle null list
            itemBuilder: (context, index) {
              if (team.pendingUserRequests == null) {
                // If pending users list is null, display a message
                return ListTile(
                  title: Text('No pending user requests'),
                );
              } else {
                final user = team.pendingUserRequests![
                    index]; // Use null assertion operator since list is non-null here
                return ListTile(
                  title: Text(
                      '${user.firstName} ${user.lastName} (${user.email})'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => {_approveJoinTeam(user, true)},
                        icon: Icon(Icons.check),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () => _approveJoinTeam(user, false),
                        icon: Icon(Icons.close),
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              }
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
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Save settings logic
              _fetchTeamData();
            },
            child: Text('Update'),
          ),
        ],
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

  void _acceptRequest(User user) {
    // Handle logic to accept the user request
    // Remove user from pending users list
    setState(() {
      _pendingUsers?.remove(user);
    });
    // You can call an API to process the acceptance on the backend
  }
}
