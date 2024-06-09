import 'package:flutter/material.dart';
import 'package:mobilizzz/services/record_service.dart';
import 'package:mobilizzz/models/record_model.dart';

class RecordProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Record> _records = [];
  List<Record> get records => _records;

    set records(List<Record> records) {
      _records = records;
      notifyListeners();
  }

  RecordProvider() {
    // Fetch records when the provider is instantiated
    getAllRecords();
  }

  // TODO use a getRecordByUser 
  Future<void> getAllRecords() async {
    final service = RecordService();
    isLoading = true;

    final response = await service.getAll();

    records = response;
    isLoading = false;
  }

    Future<bool> addRecord(Record record) async {
    final service = RecordService();
    bool success = false;
    isLoading = true;

    try {
      success = await service.addRecord(record); 
      await getAllRecords();
    } catch (error) {
      // Hsndle error
    } finally {
      isLoading = false;
    }
    return success;
  }
}