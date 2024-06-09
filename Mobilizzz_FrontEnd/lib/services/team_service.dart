import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/team_model.dart';

class TeamService {
  Future<List<Team>> getAll() async {
    const url = '${AppConstants.apiUrl}/Team/GetAll';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json.map((json) => Team.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<Team>> getTeamsByUser(int userId) async {
    dynamic url = '${AppConstants.apiUrl}/Team/GetTeamsByUser/$userId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json.map((json) => Team.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> joinTeam(int teamId, int userId) async {
    try {
      final joinTeamUrl = Uri.parse('${AppConstants.apiUrl}/Team/JoinTeam');
      final requestData = {'teamId': teamId, 'userId': userId};

      final response = await http.post(
        joinTeamUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Successfully joined team');
        // Optionally, you can update the state or perform any other action
      } else {
        print('Failed to join team: ${response.statusCode}');
        // Handle error response
      }
    } catch (error) {
      print('Error joining team: $error');
      // Handle exceptions
    }
  }

  Future<void> createTeam(Team team) async {
    try {
      final createTeamUrl = Uri.parse('${AppConstants.apiUrl}/Team/Create');

      final requestData = team.toJson();

      final response = await http.post(
        createTeamUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Team created successfully');
      } else {
        print('Failed to create team: ${response.statusCode}');
        // Handle error response
      }
    } catch (error) {
      print('Error creating team: $error');
      // Handle exceptions
    }
  }

  // Future<bool> addRecord(Record record) async {
  //   try {
  //     const url = 'http://10.0.10.55:5169/Record/Create';
  //     final uri = Uri.parse(url);
  //     final headers = {'Content-Type': 'application/json'};
  //     final body = jsonEncode(record.toJson());

  //     final response = await http.post(
  //       uri,
  //       headers: headers,
  //       body: body,
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (error) {
  //     return false;
  //   }
  // }
}
