import 'package:flutter/material.dart';
import 'package:mobilizzz/pages/search_team_page.dart';
import 'package:mobilizzz/pages/team_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';

class TeamPageWrapper extends StatelessWidget {
  const TeamPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TeamProvider>(
      builder: (context, teamProvider, child) {
        if (teamProvider.teamsForUser.isNotEmpty) {
          // If the user has teams, display the TeamPage
          return TeamPage();
        } else {
          // If the user does not have any teams, redirect to the SearchTeamPage
          return SearchTeamPage();
        }
      },
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    var _userProvider = Provider.of<AuthProvider>(context, listen: false);
    var _teamProvider = Provider.of<TeamProvider>(context, listen: false);

    _teamProvider.fetchTeamsForUser(_userProvider.user!.id);
  }

  static const List<Widget> _views = [
    HomePage(),
    TeamPageWrapper(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Teams',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
