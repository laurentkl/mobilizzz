import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/pages/team_settings_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/widgets/team_page/team_page_drawer.dart';
import 'package:mobilizzz/widgets/team_page/team_stats.dart';
import 'package:mobilizzz/widgets/team_page/users_list.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  User? _user;
  int _currentTeamId = 0;
  Team? _currentTeam;

  void _toggleTeam(int teamId) {
    setState(() {
      _currentTeamId = teamId;
      _currentTeam = Provider.of<TeamProvider>(context, listen: false)
          .teamsForUser
          .firstWhere((team) => team.id == _currentTeamId);
    });
  }

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    _user = authProvider.user;

    if (_user != null) {
      teamProvider.fetchTeamsForUser(_user!.id).then((_) {
        if (teamProvider.teamsForUser.isNotEmpty) {
          setState(() {
            _currentTeamId = teamProvider.teamsForUser.first.id!;
            _currentTeam = teamProvider.teamsForUser.first;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TeamProvider, RecordProvider>(
      builder: (context, teamProvider, recordProvider, child) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        _user = authProvider.user;

        return Container(
          color: AppConstants.backgroundColor,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppConstants.backgroundColor,
              appBar: AppBar(
                backgroundColor: AppConstants.backgroundColor,
                title: Text(
                  _currentTeam?.name ?? 'Team',
                  style: const TextStyle(color: AppConstants.primaryColor),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeamSettingsPage(
                            team: _currentTeam!,
                          ),
                        ),
                      )
                    },
                  ),
                ],
              ),
              drawer: TeamDrawer(
                teamsForUser: teamProvider.teamsForUser,
                toggleTeam: _toggleTeam,
              ),
              body: Column(
                children: [
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
                          bikeKm: 0,
                        );
                      }
                    },
                  ),
                  Expanded(
                    child: FutureBuilder<List<User>>(
                      future: _currentTeam?.fetchUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
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
            ),
          ),
        );
      },
    );
  }
}
