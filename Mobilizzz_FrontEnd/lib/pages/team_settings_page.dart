import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:provider/provider.dart'; 

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
                team.adminIds.join(', '), 
            onChanged: (value) {
              setState(() {
                _adminIds =
                    value.split(',').map((id) => int.parse(id.trim())).toList();
              });
            },
          ),
          SizedBox(height: 16.0),
          Text('Pending User Requests'), 
          ListView.builder(
            shrinkWrap: true,
            itemCount: team.pendingUserRequests?.length ??
                0, 
            itemBuilder: (context, index) {
              if (team.pendingUserRequests == null) {
                return ListTile(
                  title: Text('No pending user requests'),
                );
              } else {
                final user = team.pendingUserRequests![
                    index];
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
              // TODO
            },
            child: Text('Save Settings'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _fetchTeamData();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
