import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';

class Company {
  final int id;
  final String name;
  final List<User>? leaders;
  final List<Team>? teams;

  Company({
    required this.id,
    required this.name,
    this.leaders,
    this.teams,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    // Parse leaders
    final List<dynamic>? leadersJson = json['leaders'];
    final List<User>? leaders =
        leadersJson?.map((leaderJson) => User.fromJson(leaderJson)).toList();

    // Parse teams
    final List<dynamic>? teamsJson = json['teams'];
    final List<Team>? teams =
        teamsJson?.map((teamJson) => Team.fromJson(teamJson)).toList();

    return Company(
      id: json['id'] as int,
      name: json['name'] as String,
      leaders: leaders,
      teams: teams,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
    };

    if (leaders != null) {
      data['leaders'] = leaders!.map((leader) => leader.toJson()).toList();
    }

    if (teams != null) {
      data['teams'] = teams!.map((team) => team.toJson()).toList();
    }

    return data;
  }
}
