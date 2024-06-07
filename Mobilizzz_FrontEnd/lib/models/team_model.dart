import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/services/user_service.dart';
import 'package:mobilizzz/models/company_model.dart'; // Import your Company model

class Team {
  final int id;
  final String name;
  final int leaderId;
  final int companyId;
  final Company? company; // Add nullable company object field

  const Team({
    required this.id,
    required this.name,
    required this.leaderId,
    required this.companyId,
    this.company, // Make company parameter nullable
  });

  Future<List<User>> fetchUsers() async {
    final userService = UserService();
    return await userService.getUsersByTeam(id);
  }

  Future<double> getTotalKm() async {
    final users = await fetchUsers();
    double totalKm = 0.0;

    for (var user in users) {
      for (var record in user.records) {
        if (record.teamId == id) {
          totalKm += record.distance;
        }
      }
    }
    return totalKm;
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as int,
      name: json['name'] as String,
      leaderId: json['leaderId'] as int,
      companyId: json['companyId'] as int,
      company: json['company'] != null
          ? Company.fromJson(json['company'])
          : null, // Parse company object from JSON if not null
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'leaderId': leaderId,
      'companyId': companyId,
    };

    if (company != null) {
      data['company'] = company!.toJson(); // Include company object in JSON if not null
    }

    return data;
  }
}
