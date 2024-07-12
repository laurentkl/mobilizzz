import 'package:json_annotation/json_annotation.dart';

enum RecordType {
  @JsonValue(1)
  work,
  @JsonValue(2)
  mission,
  @JsonValue(3)
  private,
}

enum TransportMethod {
  @JsonValue(1)
  walk,
  @JsonValue(2)
  bike,
  @JsonValue(3)
  bus,
  @JsonValue(4)
  carpooling,
}
