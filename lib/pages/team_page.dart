import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/pages/add_record_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/services/user_service.dart';
import 'package:mobilizzz/widgets/team_stats.dart';
import 'package:mobilizzz/widgets/users_list.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  late User _user;
  int _currentTeamId = 0;
  late Team? _currentTeam;
  late double teamTotalKm = 0.0;

  void _toggleTeam(int teamId) {
    setState(() {
      _currentTeamId = teamId;
      _currentTeam =
          _user.teams.firstWhere((team) => team.id == _currentTeamId);
    });
  }

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _user = authProvider.user!;

    _currentTeamId = _user.teams.first.id;
    _currentTeam = _user.teams.first;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Team'), // Default title if teams are not loaded
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => {},
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Team Selection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ..._user.teams.map((team) => ListTile(
                    title: Text(team.name),
                    onTap: () {
                      _toggleTeam(team.id);
                      Navigator.pop(context); // Close the drawer
                    },
                  )),
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Center(
                  child: _user.teams != null && _user.teams.isNotEmpty
                      ? Text(
                          _user.teams[_currentTeamId - 1].name,
                          style: const TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber, // Customize the text color
                          ),
                        )
                      : const Text(
                          'Team',
                          style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber, // Customize the text color
                          ),
                        ),
                ),
                FutureBuilder<double>(
                  future: _currentTeam?.getTotalKm(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return TeamStats(
                        totalKm: snapshot.data ?? 0,
                        bikeKm: 22,
                      );
                    }
                  },
                ),
                Expanded(
                  child: FutureBuilder<List<User>>(
                    future: _currentTeam!.fetchUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No users found'));
                      } else {
                        return UsersList(
                          users: snapshot.data!,
                          teamId: _currentTeamId,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: FloatingActionButton(
                heroTag: "team-btn-insert",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddRecordPage(
                                preselectedTeamId: _currentTeamId,
                              )));
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
