import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/models/record_model.dart' as custom_record;
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

  // GlobalKey to control the ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  // Method to open the drawer
  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
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
              key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
              backgroundColor: AppConstants.backgroundColor,
              endDrawer: TeamDrawer(
                teamsForUser: teamProvider.teamsForUser,
                toggleTeam: _toggleTeam,
              ),
              appBar: AppBar(
                backgroundColor: AppConstants.backgroundColor,
                title: Text(
                  _currentTeam?.name ?? 'Team',
                  style: const TextStyle(color: AppConstants.primaryColor),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeamSettingsPage(
                            team: _currentTeam!,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  TeamStats(
                    totalKm: _currentTeam?.getTotalKm() ?? 0,
                    mostUsedTransportMethodDistance: _currentTeam
                            ?.getMostUsedTransportMethod()["distance"] ??
                        0,
                    mostUsedTransportMethodName:
                        _currentTeam?.getMostUsedTransportMethod()["name"] ??
                            "",
                    teamRecords: _currentTeam?.getAllRecords() ?? [],
                  ),
                  Expanded(
                    child: UsersList(
                      users: _currentTeam?.users ?? [],
                      teamId: _currentTeamId,
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _openDrawer,
                backgroundColor: Colors.deepPurple,
                child: const Icon(
                  Icons.screen_rotation_alt_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
