import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/services/user_service.dart';

class Team {
  final int id;
  final String name;
  final int leaderId;
  final int companyId;

  const Team({
    required this.id,
    required this.name,
    required this.leaderId,
    required this.companyId,
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
        if(record.teamId == id){
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
      // companyId: json['companyId'] as int,
      companyId: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'leaderId': leaderId,
      'companyId': companyId,
    };
  }
}
