import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/providers/user_provider.dart';
import 'package:mobilizzz/services/team_service.dart';

class TeamProvider extends ChangeNotifier {
  final TeamService _teamService = TeamService();
  List<Team> _teams = [];
  Team? _currentTeam;
  List<Team> _teamsForUser = [];
  double _currentTeamTotalKm = 0;

  List<Team> get teams => _teams;
  Team? get currentTeam => _currentTeam;

  // Data depth: Teams > Users > Records
  List<Team> get teamsForUser => _teamsForUser;
  double get currentTeamTotalKm => _currentTeamTotalKm;

  set currentTeam(Team? team) {
    _currentTeam = team;
    _currentTeamTotalKm = computeTeamTotalKm();
    notifyListeners();
  }

  void setCurrentTeamFromId(int teamId) {
    currentTeam = teamsForUser.firstWhere((team) => team.id == teamId);
  }

  bool getIsCurrentTeamAdmin(int userId) {
    if (currentTeam == null || currentTeam!.admins == null) {
      return false;
    }
    return currentTeam!.admins!.any((admin) => admin.id == userId);
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

  Future<Team> createTeam(Team team, int userId) async {
    try {
      Team createdTeam = await _teamService.createTeam(team);
      await fetchTeamsForUser(userId);
      return createdTeam;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateTeam(Team team, int userId) async {
    try {
      await _teamService.updateTeam(team);
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

  Future<void> grantAdminRights(
      int teamId, int userToPromoteId, int callerUserId) async {
    try {
      await _teamService.grantAdminRights(teamId, userToPromoteId);
      await fetchTeamsForUser(callerUserId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> ejectUser(int teamId, int userId, int callerUserId) async {
    try {
      await _teamService.ejectUser(teamId, userId);
      await fetchTeamsForUser(callerUserId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> leaveTeam(int teamId, int userId, int callerUserId) async {
    try {
      await _teamService.leaveTeam(teamId, userId);
      await fetchTeamsForUser(callerUserId);
    } catch (error) {
      throw Exception('Error leaving team: $error');
    }
  }
}
