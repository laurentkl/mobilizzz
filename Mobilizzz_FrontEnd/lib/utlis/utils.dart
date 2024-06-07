import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';

Future<List<Record>> loadMockRecords() async {
  final String response = await rootBundle.loadString('lib/mock/records.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Record.fromJson(json)).toList();
}

Future<List<User>> loadMockUsers() async {
  final String response = await rootBundle.loadString('lib/mock/users.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => User.fromJson(json)).toList();
}

Future<User> loadMockUser() async {
  final users = await loadMockUsers();
  return users.first;
}

Future<List<Team>> loadMockTeams() async {
  final String response = await rootBundle.loadString('lib/mock/teams.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Team.fromJson(json)).toList();
}