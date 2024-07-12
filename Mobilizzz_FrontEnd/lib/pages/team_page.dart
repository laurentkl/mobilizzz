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
  // GlobalKey to control the ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  // Method to open the drawer
  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<TeamProvider, RecordProvider, AuthProvider>(
      builder: (context, teamProvider, recordProvider, authProvider, child) {
        Team? currentTeam = teamProvider.currentTeam;
        return Container(
          color: AppConstants.backgroundColor,
          child: SafeArea(
            child: Scaffold(
              key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
              backgroundColor: AppConstants.backgroundColor,
              endDrawer: TeamDrawer(
                teamsForUser: teamProvider.teamsForUser,
                toggleTeam: teamProvider.toggleCurrentTeam,
              ),
              appBar: AppBar(
                backgroundColor: AppConstants.backgroundColor,
                title: Text(
                  currentTeam?.name ?? 'Team',
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
                            team: currentTeam!,
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
                    totalKm: teamProvider.currentTeamTotalKm,
                    mostUsedTransportMethodDistance:
                        currentTeam?.getMostUsedTransportMethod()["distance"] ??
                            0,
                    mostUsedTransportMethod:
                        currentTeam?.getMostUsedTransportMethod()["method"],
                    teamRecords: currentTeam?.getAllRecords() ?? [],
                  ),
                  Expanded(
                    child: UsersList(
                      users: currentTeam?.users ?? [],
                      teamId: currentTeam?.id ?? 0,
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _openDrawer,
                backgroundColor: Colors.deepPurple,
                child: const Icon(
                  Icons.social_distance,
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
