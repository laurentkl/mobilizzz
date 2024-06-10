import 'package:json_annotation/json_annotation.dart';
part 'record_model.g.dart';

@JsonSerializable()
class Record {
  final int? id;
  final String transportMethod;
  final double distance; // Using double for distance measurement
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