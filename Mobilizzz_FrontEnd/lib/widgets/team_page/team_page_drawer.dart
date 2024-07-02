import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/dialogs/add_team_dialog.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/pages/search_team_page.dart';

class TeamDrawer extends StatelessWidget {
  const TeamDrawer(
      {super.key, required this.teamsForUser, required this.toggleTeam});

  final Function(int) toggleTeam;
  final List<Team> teamsForUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
            ),
            child: Text(
              'Team Selection',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ...teamsForUser.map((team) => ListTile(
                title: Text(team.name),
                onTap: () {
                  toggleTeam(team.id!);
                  Navigator.pop(context); // Close the drawer
                },
              )),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search team'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchTeamPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Team'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AddTeamDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
