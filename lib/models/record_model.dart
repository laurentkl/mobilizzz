class Record {
  final int id;
  final String transportMethod;
  final double distance; // Using double for distance measurement
  final int userId;
  final int teamId;

  Record({
    required this.id,
    required this.transportMethod,
    required this.distance,
    required this.userId,
    required this.teamId,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'] as int,
      transportMethod: json['transportMethod'] as String,
      distance: json['distance'] as double,
      userId: json['userId'] as int,
      teamId: json['teamId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transportMethod': transportMethod,
      'distance': distance,
      'userId': userId,
      'teamId': teamId,
    };
  }
}