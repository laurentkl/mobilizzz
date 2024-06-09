import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/services/team_service.dart';
import 'package:provider/provider.dart';

class TeamProvider extends ChangeNotifier {
  final TeamService _teamService = TeamService();
  List<Team> _teams = [];
  List<Team> _teamsForUser = [];

  List<Team> get teams => _teams;
  List<Team> get teamsForUser => _teamsForUser;

  // Method to fetch all teams
  Future<void> fetchTeams() async {
    try {
      _teams = await _teamService.getAll();
      notifyListeners();
    } catch (error) {
      print('Error fetching teams: $error');
      // Handle error accordingly
    }
  }

    // Method to fetch all teams
  Future<void> fetchTeamsForUser(int userId) async {
    try {
      _teamsForUser = await _teamService.getTeamsByUser(userId);
      notifyListeners();
    } catch (error) {
      print('Error fetching teams: $error');
      // Handle error accordingly
    }
  }

  // Method to join a team
  Future<void> joinTeam(int teamId, int userId) async {
    try {
      await _teamService.joinTeam(teamId, userId);
      // Optionally, you can refetch teams or update the state
      await fetchTeamsForUser(userId);
    } catch (error) {
      print('Error joining team: $error');
      // Handle error accordingly
    }
  }

  // Add other methods as needed based on your app requirements

  // For example, method to leave a team
  // Future<void> leaveTeam(int teamId, int userId) async {
  //   try {
  //     await _teamService.leaveTeam(teamId, userId);
  //     // Optionally, you can refetch teams or update the state
  //     await fetchTeams();
  //   } catch (error) {
  //     print('Error leaving team: $error');
  //     // Handle error accordingly
  //   }
  // }
}
