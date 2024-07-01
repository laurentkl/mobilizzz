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
      type: json['type'] as String,
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
  val['transportMethod'] = instance.transportMethod;
  val['distance'] = instance.distance;
  val['userId'] = instance.userId;
  val['teamId'] = instance.teamId;
  val['type'] = instance.type;
  writeNotNull('creationDate', instance.creationDate?.toIso8601String());
  return val;
}
