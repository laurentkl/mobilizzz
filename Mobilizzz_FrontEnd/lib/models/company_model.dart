import 'package:json_annotation/json_annotation.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';

part 'company_model.g.dart';

@JsonSerializable(includeIfNull: false)
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

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
