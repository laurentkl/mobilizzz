import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/services/team_service.dart';

class TeamProvider extends ChangeNotifier {
  final TeamService _teamService = TeamService();
  List<Team> _teams = [];
  Team? _currentTeam;
  List<Team> _teamsForUser = [];
  double _currentTeamTotalKm = 0;

  List<Team> get teams => _teams;
  Team? get currentTeam => _currentTeam;
  List<Team> get teamsForUser => _teamsForUser;
  double get currentTeamTotalKm => _currentTeamTotalKm;

  set currentTeam(Team? team) {
    _currentTeam = team;
    _currentTeamTotalKm = computeTeamTotalKm();
    notifyListeners();
  }

  Future<void> fetchTeams() async {
    try {
      _teams = await _teamService.getAll();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  // This function is responsible to maintain the list of teams for the current user up to date
  // It's also maintening the current team up to date
  Future<void> fetchTeamsForUser(int userId) async {
    try {
      _teamsForUser = await _teamService.getTeamsByUser(userId);

      if (currentTeam == null && _teamsForUser.isNotEmpty) {
        currentTeam = _teamsForUser.first;
      } else if (currentTeam != null) {
        currentTeam =
            _teamsForUser.firstWhere((team) => team.id == currentTeam!.id);
      }

      _currentTeamTotalKm = computeTeamTotalKm();
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

  Team? getTeamFromTeamId(int teamId) {
    if (teamsForUser.isEmpty) {
      return null;
    }
    return teamsForUser.firstWhere((team) => team.id == teamId);
  }

  void toggleCurrentTeam(int teamId) {
    currentTeam = teamsForUser.firstWhere((team) => team.id == teamId);
  }

  double computeTeamTotalKm() {
    double totalKm = 0.0;

    if (currentTeam == null) {
      return totalKm;
    }

    for (var user in currentTeam!.users!) {
      if (user.records != null) {
        for (var record in user.records!) {
          if (record.teamId == currentTeam!.id) {
            totalKm += record.distance;
          }
        }
      }
    }

    return totalKm;
  }
}
