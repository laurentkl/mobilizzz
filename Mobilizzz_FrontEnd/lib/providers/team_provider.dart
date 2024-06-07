import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/services/team_service.dart';

class TeamProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Team> _teams = [];
  List<Team> get teams => _teams;

    set teams(List<Team> teams) {
      _teams = teams;
      notifyListeners();
  }

  Future<void> getAllUsers() async {
    final service = TeamService();
    isLoading = true;

    final response = await service.getAll();

    teams = response;
    isLoading = false;
  }

}