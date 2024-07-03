import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/widgets/team_settings_page/managed_user_list.dart';
import 'package:mobilizzz/widgets/team_settings_page/managed_user_row.dart';
import 'package:mobilizzz/widgets/team_settings_page/pending_users_list.dart';
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
      await teamProvider.approveTeamRequest(
          authProvider.user!.id, widget.team.id!, requestUser.id, isApproved);
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
    _teamName = widget.team.name;
    _adminIds = widget.team.adminIds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        title: const Text('Team Settings Page'),
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

  Widget _buildSettingsForm(BuildContext context, Team team) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Team Name',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            initialValue: team.name,
            onChanged: (value) {
              setState(() {
                _teamName = value;
              });
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white54),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            flex: 4,
            child: ManagedUsersList(team: team),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement save settings functionality
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Save Settings'),
          ),
        ],
      ),
    );
  }
}
