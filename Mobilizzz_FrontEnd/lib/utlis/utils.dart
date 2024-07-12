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

IconData getTransportMethodIcon(TransportMethod? method) {
  switch (method) {
    case TransportMethod.walk:
      return AppConstants.transportMethodWalkIcon;
    case TransportMethod.bike:
      return AppConstants.transportMethodBikeIcon;
    case TransportMethod.bus:
      return AppConstants.transportMethodBusIcon;
    case TransportMethod.carpooling:
      return AppConstants.transportMethodCarpoolingIcon;
    default:
      return Icons.error;
  }
}

String getTransportMethodString(TransportMethod method) {
  switch (method) {
    case TransportMethod.walk:
      return 'Marche';
    case TransportMethod.bike:
      return '2 Roues';
    case TransportMethod.bus:
      return 'Bus';
    case TransportMethod.carpooling:
      return 'Co-Voit';
    default:
      return 'Inconnu';
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
