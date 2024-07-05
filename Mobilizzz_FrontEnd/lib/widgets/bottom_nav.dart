import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/pages/add_record_page.dart';
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
          return TeamPage();
        } else {
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void changeTabIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _views = [
      HomePage(),
      AddRecordPage(changeTabIndex: changeTabIndex),
      TeamPageWrapper(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppConstants.backgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Ajouter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Teams',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppConstants.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
