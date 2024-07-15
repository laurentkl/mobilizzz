import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/team_model.dart';

class TeamService {
  Future<List<Team>> getAll() async {
    const url = '${AppConstants.apiUrl}/Team/GetAll';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;
        return json.map((json) => Team.fromJson(json)).toList();
      } else {
        throw "${jsonDecode(response.body)['message']}  ${response.statusCode}";
      }
    } catch (error) {
      throw Exception('Failed to fetch teams: $error');
    }
  }

  Future<List<Team>> getTeamsByUser(int userId) async {
    final url = '${AppConstants.apiUrl}/Team/GetTeamsByUser/$userId';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;
        return json.map((json) => Team.fromJson(json)).toList();
      } else {
        throw "${jsonDecode(response.body)['message']}  ${response.statusCode}";
      }
    } catch (error) {
      throw Exception('Failed to fetch teams for user $userId: $error');
    }
  }

  Future<void> joinTeamRequest(int teamId, int userId) async {
    final joinTeamUrl =
        Uri.parse('${AppConstants.apiUrl}/Team/JoinTeamRequest');
    final requestData = {'teamId': teamId, 'userId': userId};

    try {
      final response = await http.post(
        joinTeamUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode != 200) {
        throw "${jsonDecode(response.body)['message']} ${response.statusCode}";
      }
    } catch (error) {
      throw Exception('Error joining team: $error');
    }
  }

  Future<void> approveTeamRequest(
      int teamId, int userId, bool isApproved) async {
    final uri = Uri.parse('${AppConstants.apiUrl}/Team/ApproveTeamRequest');
    final requestData = {
      'teamId': teamId,
      'userId': userId,
      'isApproved': isApproved
    };

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode != 200) {
        throw "${jsonDecode(response.body)['message']} ${response.statusCode}";
      }
    } catch (error) {
      throw Exception('Error approving team request: $error');
    }
  }

  Future<Team> createTeam(Team team) async {
    final createTeamUrl = Uri.parse('${AppConstants.apiUrl}/Team/Create');
    final requestData = team.toJson();

    try {
      final response = await http.post(
        createTeamUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Team created successfully, parse the response JSON into a Team object
        final jsonResponse = jsonDecode(response.body);
        final createdTeam = Team.fromJson(jsonResponse['team']);
        return createdTeam;
      } else {
        // Handle HTTP error
        throw Exception(
            "${jsonDecode(response.body)['message']}  ${response.statusCode}");
      }
    } catch (error) {
      // Handle network or JSON decoding errors
      throw Exception('Error creating team: $error');
    }
  }

  Future<Team> updateTeam(Team team) async {
    final updateTeamUrl =
        Uri.parse('${AppConstants.apiUrl}/Team/Update/${team.id}');
    final requestData = team.toJson();

    try {
      final response = await http.put(
        updateTeamUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final updatedTeam = Team.fromJson(jsonResponse['team']);
        return updatedTeam;
      } else {
        throw Exception(
            "${jsonDecode(response.body)['message']}  ${response.statusCode}");
      }
    } catch (error) {
      throw Exception('Error updating team: $error');
    }
  }
}
