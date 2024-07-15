import 'package:json_annotation/json_annotation.dart';
import 'package:mobilizzz/enums/enums.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/services/record_service.dart';
import 'package:mobilizzz/services/user_service.dart';
import 'package:mobilizzz/models/company_model.dart';
import 'package:mobilizzz/utlis/utils.dart'; // Import your Company model

part 'team_model.g.dart';

@JsonSerializable(includeIfNull: false)
class Team {
  final int? id;
  final String name;
  final bool isHidden;
  final bool isPrivate;
  final int companyId;
  final Company? company;
  final List<User>? pendingUserRequests;
  final List<User>? users;
  final List<User>? admins;

  const Team({
    this.id,
    required this.name,
    required this.isHidden,
    required this.isPrivate,
    required this.companyId,
    this.admins,
    this.company,
    this.users,
    this.pendingUserRequests,
  });

  Future<List<User>> fetchUsers() async {
    final userService = UserService();
    return await userService.getUsersByTeam(id!);
  }

  Future<List<Record>> fetchRecords() async {
    final recordService = RecordService();
    return await recordService.getRecordsByTeamId(id!);
  }

  List<Record> getAllRecords() {
    List<Record> records = [];

    for (var user in users!) {
      if (user.records != null) {
        for (var record in user.records!) {
          if (record.teamId == id) {
            records.add(record);
          }
        }
      }
    }

    return records;
  }

  double getTotalBikeKm() {
    double totalKm = 0.0;

    for (var user in users!) {
      if (user.records != null) {
        for (var record in user.records!) {
          if (record.teamId == id && record.transportMethod == 'bike') {
            totalKm += record.distance;
          }
        }
      }
    }

    return totalKm;
  }

  Map<String, dynamic> getMostUsedTransportMethod() {
    Map<TransportMethod, double> transportMethodDistances = {};

    for (var user in users!) {
      if (user.records != null) {
        for (var record in user.records!) {
          if (record.teamId == id) {
            transportMethodDistances.update(
              record.transportMethod,
              (value) => value + record.distance,
              ifAbsent: () => record.distance,
            );
          }
        }
      }
    }

    TransportMethod? mostUsedTransportMethod;
    double maxDistance = 0.0;

    transportMethodDistances.forEach((method, distance) {
      if (distance > maxDistance) {
        maxDistance = distance;
        mostUsedTransportMethod = method;
      }
    });

    if (mostUsedTransportMethod == null) {
      return {
        'name': 'None',
        'distance': 0.0,
      };
    }

    return {
      'method': mostUsedTransportMethod,
      'distance': maxDistance,
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
