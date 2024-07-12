// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      transportMethod:
          $enumDecode(_$TransportMethodEnumMap, json['transportMethod']),
      distance: (json['distance'] as num).toDouble(),
      userId: (json['userId'] as num).toInt(),
      teamId: (json['teamId'] as num?)?.toInt(),
      recordType: $enumDecode(_$RecordTypeEnumMap, json['recordType']),
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      creationDate: json['creationDate'] == null
          ? null
          : DateTime.parse(json['creationDate'] as String),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecordToJson(Record instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['transportMethod'] = _$TransportMethodEnumMap[instance.transportMethod]!;
  val['distance'] = instance.distance;
  val['userId'] = instance.userId;
  writeNotNull('teamId', instance.teamId);
  writeNotNull('team', instance.team);
  val['recordType'] = _$RecordTypeEnumMap[instance.recordType]!;
  writeNotNull('creationDate', instance.creationDate?.toIso8601String());
  return val;
}

const _$TransportMethodEnumMap = {
  TransportMethod.walk: 1,
  TransportMethod.bike: 2,
  TransportMethod.bus: 3,
  TransportMethod.carpooling: 4,
};

const _$RecordTypeEnumMap = {
  RecordType.work: 1,
  RecordType.mission: 2,
  RecordType.private: 3,
};
