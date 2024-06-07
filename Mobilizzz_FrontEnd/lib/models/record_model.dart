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

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'] as int,
      transportMethod: json['transportMethod'] as String,
      distance: double.tryParse(json['distance'].toString()) ?? 0.0,
      userId: json['userId'] as int,
      teamId: json['teamId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'transportMethod': transportMethod,
      'distance': distance,
      'userId': userId,
      'teamId': teamId,
    };
    if (id != null) {
      json['id'] = id;
    }
    return json;
  }
}