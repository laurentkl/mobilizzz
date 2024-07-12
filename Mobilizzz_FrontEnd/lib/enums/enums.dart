import 'package:json_annotation/json_annotation.dart';

enum RecordType {
  @JsonValue(1)
  work,
  @JsonValue(2)
  mission,
  @JsonValue(3)
  private,
}
