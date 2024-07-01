import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/record_model.dart';

class RecordService {
  Future<List<Record>> getAll() async {
    const url = '${AppConstants.apiUrl}/Record/GetAll';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json.map((json) => Record.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<Record>> getRecordsByUserId(int userId) async {
    dynamic url = '${AppConstants.apiUrl}/Record/GetRecordsByUserId/$userId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json.map((json) => Record.fromJson(json)).toList();
    }
    return [];
  }

  Future<bool> addRecord(Record record) async {
    try {
      const url = '${AppConstants.apiUrl}/Record/Create';
      final uri = Uri.parse(url);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(record.toJson());

      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
