import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilizzz/models/record_model.dart';

class RecordService {
  Future<List<Record>> getAll() async {
    const url = 'http://10.0.10.55:5169/Record/GetAll';
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
      const url = 'http://10.0.10.55:5169/Record/Create';
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
