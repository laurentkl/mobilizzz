// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      transportMethod: json['transportMethod'] as String,
      distance: (json['distance'] as num).toDouble(),
      userId: (json['userId'] as num).toInt(),
      teamId: (json['teamId'] as num).toInt(),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'id': instance.id,
      'transportMethod': instance.transportMethod,
      'distance': instance.distance,
      'userId': instance.userId,
      'teamId': instance.teamId,
    };
