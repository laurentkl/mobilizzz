import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:mobilizzz/models/record_model.dart';

class User {
  final int id;
  final String lastName;
  final String firstName;
  final String email;
  List<Record> records = [];
  List<Team> teams = [];

  User({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
  });

  List<Record> getRecordsForUserByTeam(teamId) {
    return records.where((record) => record.teamId == teamId).toList();
  }

  double getTotalDistanceByTeam(teamId) {
    final userRecordsByTeam = getRecordsForUserByTeam(teamId);
    double totalDistance = 0.0;

    for (final record in userRecordsByTeam) {
      if(record.teamId == teamId) {
        totalDistance += record.distance; 
      }
    }
    return totalDistance;
  }


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': lastName,
      'firstName': firstName,
      'email': email,
    };
  }
}
