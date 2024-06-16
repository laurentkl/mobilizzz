import 'package:json_annotation/json_annotation.dart';
part 'record_model.g.dart';

@JsonSerializable(includeIfNull: false)
class Record {
  final int? id;
  final String transportMethod;
  final double distance; 
  final int userId;
  final int teamId;

  Record({
    required this.transportMethod,
    required this.distance,
    required this.userId,
    required this.teamId,
    this.id,
  });

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
  Map<String, dynamic> toJson() => _$RecordToJson(this);

}