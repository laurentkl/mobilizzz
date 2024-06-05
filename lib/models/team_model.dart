class Team {
  final int id;
  final String name;
  final int leaderId;
  final int companyId;

  const Team({
    required this.id,
    required this.name,
    required this.leaderId,
    required this.companyId,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as int,
      name: json['name'] as String,
      leaderId: json['leaderId'] as int,
      // companyId: json['companyId'] as int,
      companyId: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'leaderId': leaderId,
      'companyId': companyId,
    };
  }
}
