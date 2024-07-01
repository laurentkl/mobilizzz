import 'package:flutter/material.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/services/record_service.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:provider/provider.dart';

class RecordProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Record> _records = [];
  List<Record> _userRecords = [];
  List<Record> _filteredUserRecords = [];
  String _selectedTransportTypeForFilter = '';

  List<Record> get records => _records;
  List<Record> get userRecords => _userRecords;
  List<Record> get filteredUserRecords => _filteredUserRecords;

  set records(List<Record> records) {
    _records = records;
    notifyListeners();
  }

  set userRecords(List<Record> userRecords) {
    _userRecords = userRecords;
    _filteredUserRecords = userRecords;
    notifyListeners();
  }

  Future<void> getAllRecords() async {
    final service = RecordService();
    isLoading = true;

    final response = await service.getAll();

    records = response;
    isLoading = false;
  }

  Future<void> getRecordsById(int userId) async {
    final service = RecordService();
    isLoading = true;

    final response = await service.getRecordsByUserId(userId);

    userRecords = response;
    isLoading = false;
  }

  Future<bool> addRecord(Record record, BuildContext context) async {
    final service = RecordService();
    bool success = false;
    isLoading = true;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      success = await service.addRecord(record);
      await getRecordsById(authProvider.user!.id);
    } catch (error) {
      // Hsndle error
    } finally {
      isLoading = false;
    }
    return success;
  }

  void filterByTransportType(String transportType) {
    _selectedTransportTypeForFilter = transportType;
    _filterRecords();
    notifyListeners();
  }

  void _filterRecords() {
    if (_selectedTransportTypeForFilter.isEmpty) {
      _filteredUserRecords = _userRecords;
    } else {
      _filteredUserRecords = _userRecords
          .where((record) =>
              record.transportMethod == _selectedTransportTypeForFilter)
          .toList();
    }
  }
}
