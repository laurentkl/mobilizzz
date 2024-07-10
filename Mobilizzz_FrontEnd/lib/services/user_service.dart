import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/user_model.dart';

class UserService {
  Future<List<User>> getAll() async {
    const url = '${AppConstants.apiUrl}/User/GetAll';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json.map((json) => User.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<User>> getUsersByTeam(int teamId) async {
    dynamic url = '${AppConstants.apiUrl}/User/GetUsersByTeam/$teamId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json.map((json) => User.fromJson(json)).toList();
    }
    return [];
  }
}
