import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/enums/enums.dart';
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
    case 'carpooling':
      return Icons.directions_car;
    default:
      return Icons.error;
  }
}

IconData getTypeIcon(RecordType type) {
  switch (type) {
    case RecordType.mission:
      return AppConstants.recordTypeMissionIcon;
    case RecordType.private:
      return AppConstants.recordTypePrivateIcon;
    case RecordType.work:
      return AppConstants.recordTypeWorkIcon;
    default:
      return Icons.error;
  }
}

String getRecordTypeString(RecordType type) {
  switch (type) {
    case RecordType.mission:
      return 'Mission';
    case RecordType.private:
      return 'Privé';
    case RecordType.work:
      return 'Travail';
    default:
      return 'Inconnu';
  }
}
