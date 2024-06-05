import 'package:flutter/material.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;
  List<User> _users = [];
  List<User> get users => _users;

    set users(List<User> users) {
      _users = users;
      notifyListeners();
  }

  Future<void> getAllUsers() async {
    final service = UserService();
    isLoading = true;

    final response = await service.getAll();

    users = response;
    isLoading = false;
  }

    Future<void> getTeamUsers(teamId) async {
    final service = UserService();
    isLoading = true;

    final response = await service.getUsersByTeam(teamId);

    users = response;
    isLoading = false;
  }
}