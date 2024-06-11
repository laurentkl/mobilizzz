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
      pendingUserRequests: (json['pendingUserRequests'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adminIds': instance.adminIds,
      'companyId': instance.companyId,
      'company': instance.company,
      'pendingUserRequests': instance.pendingUserRequests,
    };
