import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/dialogs/join_team_dialog.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/services/team_service.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchTeamPage extends StatefulWidget {
  const SearchTeamPage({Key? key}) : super(key: key);

  @override
  _SearchTeamPageState createState() => _SearchTeamPageState();
}

class _SearchTeamPageState extends State<SearchTeamPage> {
  late Future<List<Team>> _teamsFuture;
  final TeamService _teamService = TeamService();

  @override
  void initState() {
    super.initState();
    _teamsFuture = _teamService.getAll();
  }

  Future<void> _requestJoinTeam(Team team) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final userId =
        authProvider.user!.id; // Get the user ID from the auth provider
    try {
      await teamProvider.joinTeam(team.id!, userId);
      // Handle successful join team response
      print('Successfully joined team: ${team.name}');
    } catch (error) {
      print('Error joining team: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Team'),
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
              decoration: InputDecoration(
                hintText: 'Search team...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Search Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<Team>>(
                future: _teamsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final teams = snapshot.data!;
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
                                onRequestJoin: () => _requestJoinTeam(team),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
