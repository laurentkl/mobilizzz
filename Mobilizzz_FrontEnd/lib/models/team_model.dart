import 'package:json_annotation/json_annotation.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/services/user_service.dart';
import 'package:mobilizzz/models/company_model.dart'; // Import your Company model

part 'team_model.g.dart';

@JsonSerializable()
class Team {
  final int? id;
  final String name;
  final List<int> adminIds;
  final int companyId;
  final Company? company; // Add nullable company object field
  final List<User>? pendingUserRequests; // Add nullable company object field

  const Team({
    this.id,
    required this.name,
    required this.adminIds,
    required this.companyId,
    this.company, // Make company parameter nullable
    this.pendingUserRequests, // Make company parameter nullable
  });

  Future<List<User>> fetchUsers() async {
    final userService = UserService();
    return await userService.getUsersByTeam(id);
  }

  Future<double> getTotalKm() async {
    final users = await fetchUsers();
    double totalKm = 0.0;

    for (var user in users) {
      if (user.records != null) {
        for (var record in user.records!) {
          if (record.teamId == id) {
            totalKm += record.distance;
          }
        }
      }
    }
    return totalKm;
  }

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
