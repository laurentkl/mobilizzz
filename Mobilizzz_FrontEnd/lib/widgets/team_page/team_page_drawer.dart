import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/dialogs/add_team_dialog.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/pages/search_team_page.dart';

class TeamDrawer extends StatelessWidget {
  const TeamDrawer({
    Key? key,
    required this.teamsForUser,
    required this.toggleTeam,
  }) : super(key: key);

  final Function(int) toggleTeam;
  final List<Team> teamsForUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.0), // Ajustez ce rayon comme nécessaire
          bottomRight:
              Radius.circular(8.0), // Ajustez ce rayon comme nécessaire
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
            width: double.infinity,
            color: AppConstants.primaryColor,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Switcher de Team',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Vos équipes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Chercher une équipe'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchTeamPage(),
                      ),
                    );
                  },
                ),
                const Divider(),
                ...teamsForUser.map((team) => ListTile(
                      title: Text(
                        team.name,
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        toggleTeam(team.id!);
                        Navigator.pop(context); // Close the drawer
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
