import 'package:flutter/material.dart';
import 'package:mobilizzz/pages/search_team_page.dart';
import 'package:mobilizzz/pages/team_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';

class TeamPageWrapper extends StatelessWidget {
  const TeamPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user != null && user.teams != null && user.teams.isNotEmpty) {
      // Si l'utilisateur a des équipes, affichez la page de l'équipe
      return TeamPage();
    } else {
      // Si l'utilisateur n'a pas d'équipe, redirigez-le vers la page de recherche d'équipe
      return SearchTeamPage();
    }
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

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
