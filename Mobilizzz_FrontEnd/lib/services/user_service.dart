import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/user_model.dart';

class UserService {
  Future<List<User>> getAll() async {
    const url = '${AppConstants.apiUrl}/User/GetAll';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;
        return json.map((json) => User.fromJson(json)).toList();
      } else {
        throw "${jsonDecode(response.body)['message']} ${response.statusCode}";
      }
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }

  Future<List<User>> getUsersByTeam(int teamId) async {
    final url = '${AppConstants.apiUrl}/User/GetUsersByTeam/$teamId';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;
        return json.map((json) => User.fromJson(json)).toList();
      } else {
        throw "${jsonDecode(response.body)['message']} ${response.statusCode}";
      }
    } catch (error) {
      throw Exception('Failed to fetch users for team $teamId: $error');
    }
  }

  Future<bool> updateUser(int id, User user) async {
    final url = '${AppConstants.apiUrl}/User/Update/$id';
    final uri = Uri.parse(url);

    try {
      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw "${jsonDecode(response.body)['message']} ${response.statusCode}";
      }
    } catch (error) {
      throw Exception('Failed to update user: $error');
    }
  }

  Future<bool> deleteUser(int id) async {
    final url = '${AppConstants.apiUrl}/User/Delete/$id';
    final uri = Uri.parse(url);

    try {
      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw "${jsonDecode(response.body)['message']} ${response.statusCode}";
      }
    } catch (error) {
      throw Exception('Failed to delete user: $error');
    }
  }
}
