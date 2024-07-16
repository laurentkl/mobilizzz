// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      isHidden: json['isHidden'] as bool,
      isPrivate: json['isPrivate'] as bool,
      companyId: (json['companyId'] as num).toInt(),
      admins: (json['admins'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
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
  val['isHidden'] = instance.isHidden;
  val['isPrivate'] = instance.isPrivate;
  val['companyId'] = instance.companyId;
  writeNotNull('company', instance.company);
  writeNotNull('pendingUserRequests', instance.pendingUserRequests);
  writeNotNull('users', instance.users);
  writeNotNull('admins', instance.admins);
  return val;
}
