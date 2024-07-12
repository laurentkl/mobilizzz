import 'package:json_annotation/json_annotation.dart';
import 'package:mobilizzz/enums/enums.dart';
import 'package:mobilizzz/models/team_model.dart';
part 'record_model.g.dart';

@JsonSerializable(includeIfNull: false)
class Record {
  final int? id;
  final TransportMethod transportMethod;
  final double distance;
  final int userId;
  final int? teamId;
  final Team? team;
  final RecordType recordType;
  final DateTime? creationDate;

  Record({
    required this.transportMethod,
    required this.distance,
    required this.userId,
    required this.teamId,
    required this.recordType,
    this.team,
    this.creationDate,
    this.id,
  });

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
  Map<String, dynamic> toJson() => _$RecordToJson(this);
}
