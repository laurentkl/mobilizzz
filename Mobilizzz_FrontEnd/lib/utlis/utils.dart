import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:provider/provider.dart';

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

IconData getTransportIcon(String transportMethod) {
  switch (transportMethod) {
    case 'bike':
      return Icons.directions_bike;
    case 'bus':
      return Icons.directions_bus;
    case 'walk':
      return Icons.directions_walk;
    default:
      return Icons.error;
  }
}

IconData getTypeIcon(String type) {
  switch (type.toLowerCase()) {
    case 'mission':
      return Icons.track_changes_outlined;
    case 'personal':
      return Icons.favorite;
    case 'work':
      return Icons.alarm;
    default:
      return Icons.error;
  }
}
