import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/utlis/utils.dart';

class UserProvider extends ChangeNotifier {
  List<User>? _users;

  List<User>? get users => _users;

  set users(List<User>? users) {
    _users = users;
    notifyListeners(); // Notify listeners about user update
  }

  Future<List<User>> loadMockUsers() async {
    final String response = await rootBundle.loadString('lib/mock/users.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => User.fromJson(json)).toList();
  }

  getDataFromAPI() async {
    try {
      final response = await loadMockUsers();

      if (response.isNotEmpty) { // Corrected line with removed extra brace
        for (var user in response) {
          user.records = await fetchRecordsForUser(user.id);
          print(user);
        }
        users = response;

      }

      print(users);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Record>> fetchRecordsForUser(userId) async {
    final allRecords = await loadMockRecords();
    return allRecords.where((record) => record.userId == userId).toList();
  }
}
