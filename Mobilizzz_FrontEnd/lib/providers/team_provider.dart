import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/services/team_service.dart';

class TeamProvider extends ChangeNotifier {
  final TeamService _teamService = TeamService();
  List<Team> _teams = [];
  List<Team> _teamsForUser = [];

  List<Team> get teams => _teams;
  List<Team> get teamsForUser => _teamsForUser;

  Future<void> fetchTeams() async {
    try {
      _teams = await _teamService.getAll();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchTeamsForUser(int userId) async {
    try {
      _teamsForUser = await _teamService.getTeamsByUser(userId);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> joinTeamRequest(int teamId, int userId) async {
    try {
      await _teamService.joinTeamRequest(teamId, userId);
      await fetchTeamsForUser(userId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> approveTeamRequest(
      int callerUserId, int teamId, int userId, bool isApproved) async {
    try {
      await _teamService.approveTeamRequest(teamId, userId, isApproved);
      await fetchTeamsForUser(callerUserId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createTeam(Team team, int userId) async {
    try {
      await _teamService.createTeam(team);
      await fetchTeamsForUser(userId);
    } catch (error) {
      rethrow;
    }
  }

  Team getUserTeamFromId(int id) {
    return teamsForUser.firstWhere((team) => team.id == id);
  }
}
