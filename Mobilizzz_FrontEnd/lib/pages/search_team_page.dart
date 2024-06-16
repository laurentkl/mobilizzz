import 'package:flutter/material.dart';
import 'package:mobilizzz/dialogs/join_team_dialog.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:provider/provider.dart';

class SearchTeamPage extends StatefulWidget {
  const SearchTeamPage({Key? key}) : super(key: key);

  @override
  State<SearchTeamPage> createState() => _SearchTeamPageState();
}

class _SearchTeamPageState extends State<SearchTeamPage> {
  @override
  void initState() {
    super.initState();
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    teamProvider.fetchTeams(); 
  }

  Future<void> _requestJoinTeam(BuildContext context, Team team) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final userId = authProvider.user!.id;
    try {
      await teamProvider.joinTeamRequest(team.id!, userId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request sent successfully")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  void _fetchTeamData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false); 
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    await teamProvider.fetchTeamsForUser(authProvider.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Team'),
        actions: [
          IconButton(
            onPressed: () {
              _fetchTeamData();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                // Perform search logic here if needed
              },
              decoration: const InputDecoration(
                hintText: 'Search team...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Search Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Consumer<TeamProvider>(
                builder: (context, teamProvider, child) {
                  final teams = teamProvider.teams;
                  return ListView.builder(
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      final team = teams[index];
                      return ListTile(
                        title: Text(team.name),
                        subtitle: Text(team.company?.name ?? ""),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => JoinTeamDialog(
                              teamName: team.name,
                              onRequestJoin: () =>
                                  _requestJoinTeam(context, team),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
