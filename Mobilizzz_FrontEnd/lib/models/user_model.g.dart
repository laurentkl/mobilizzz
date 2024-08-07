// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      userName: json['userName'] as String,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
    )
      ..records = (json['records'] as List<dynamic>?)
          ?.map((e) => Record.fromJson(e as Map<String, dynamic>))
          .toList()
      ..teams = (json['teams'] as List<dynamic>?)
          ?.map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'userName': instance.userName,
    'lastName': instance.lastName,
    'firstName': instance.firstName,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('password', instance.password);
  writeNotNull('records', instance.records);
  writeNotNull('teams', instance.teams);
  return val;
}
