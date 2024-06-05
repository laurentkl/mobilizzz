import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/services/user_service.dart';
import 'package:mobilizzz/widgets/users_list.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  late Future<List<User>> _futureUsers;
  late List<Team>? _teams;
  int _currentTeamId = 1;

  Future<List<User>> _fetchUsers(int teamId) async {
    final userService = UserService();
    return await userService.getUsersByTeam(teamId);
  }

  void _toggleTeamId(int teamId) {
    setState(() {
      _currentTeamId = teamId;
      _futureUsers = _fetchUsers(teamId);
    });
  }

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final User? user = authProvider.user;

    _teams = user?.teams;

    _futureUsers = _fetchUsers(_currentTeamId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Team'), // Default title if teams are not loaded
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_1),
              onPressed: () => _toggleTeamId(1),
            ),
            IconButton(
              icon: const Icon(Icons.filter_2),
              onPressed: () => _toggleTeamId(2),
            ),
            IconButton(
              icon: const Icon(Icons.filter_3),
              onPressed: () => _toggleTeamId(3),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Center(
                  child: _teams != null && _teams!.isNotEmpty
                      ? Text(
                          _teams![_currentTeamId - 1].name,
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
                Expanded(
                  child: FutureBuilder<List<User>>(
                    future: _futureUsers,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No users found'));
                      } else {
                        return UsersList(users: snapshot.data!, teamId: _currentTeamId,);
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
                  // Handle button press
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
