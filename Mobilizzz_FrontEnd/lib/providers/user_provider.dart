import 'package:flutter/material.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/services/user_service.dart';
import 'package:provider/provider.dart';

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
    notifyListeners();

    try {
      final response = await service.getAll();
      users = response;
    } catch (error) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTeamUsers(int teamId) async {
    final service = UserService();
    isLoading = true;
    notifyListeners();

    try {
      final response = await service.getUsersByTeam(teamId);
      users = response;
    } catch (error) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(int id, User user, BuildContext context) async {
    final service = UserService();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);

    isLoading = true;
    notifyListeners();

    try {
      final success = await service.updateUser(id, user);

      if (success) {
        authProvider.user = user;
        // Todo replace with a more efficient way to update the user in the team
        teamProvider.fetchTeamsForUser(user.id);
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    final service = UserService();
    isLoading = true;
    notifyListeners();

    try {
      final success = await service.deleteUser(id);

      if (success) {
        _users.removeWhere((user) => user.id == id);
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
