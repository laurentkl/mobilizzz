// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      adminIds: (json['adminIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      companyId: (json['companyId'] as num).toInt(),
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingUserRequests: (json['pendingUserRequests'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeamToJson(Team instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['adminIds'] = instance.adminIds;
  val['companyId'] = instance.companyId;
  writeNotNull('company', instance.company);
  writeNotNull('pendingUserRequests', instance.pendingUserRequests);
  writeNotNull('users', instance.users);
  return val;
}
