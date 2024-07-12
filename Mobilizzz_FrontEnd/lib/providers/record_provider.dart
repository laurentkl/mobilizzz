import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobilizzz/enums/enums.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/services/record_service.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:provider/provider.dart';

class RecordProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Record> _records = [];
  List<Record> _userRecords = [];
  List<Record> _filteredUserRecords = [];

  TransportMethod? _selectedTransportMethodForFilter;
  RecordType? _selectedTypeForFilter;

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

  Future<void> getRecordsByUserId(int userId) async {
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
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);

    int userId = authProvider.user!.id;

    try {
      success = await service.addRecord(record);
      // Fetch the records to update the records in the user view
      await getRecordsByUserId(userId);
      // Fetch the teams to update the records in the team view
      await teamProvider.fetchTeamsForUser(userId);
    } catch (error) {
      // Hsndle error
    } finally {
      isLoading = false;
    }
    return success;
  }

  Map<String, dynamic> get mostUsedTransportMethod {
    Map<TransportMethod, double> transportMethodDistances = {};

    for (var record in userRecords) {
      if (transportMethodDistances.containsKey(record.transportMethod)) {
        transportMethodDistances[record.transportMethod] =
            transportMethodDistances[record.transportMethod]! + record.distance;
      } else {
        transportMethodDistances[record.transportMethod] = record.distance;
      }
    }

    TransportMethod? mostUsedTransportMethod;
    double maxDistance = 0.0;

    transportMethodDistances.forEach((method, distance) {
      if (distance > maxDistance) {
        maxDistance = distance;
        mostUsedTransportMethod = method;
      }
    });

    return {
      'name': mostUsedTransportMethod,
      'distance': maxDistance,
    };
  }

  double get totalKm {
    double totalKm = 0.0;

    for (var record in userRecords) {
      totalKm += record.distance;
    }

    return totalKm;
  }

  int get consecutiveRecords {
    if (userRecords.isEmpty) {
      return 0;
    }

    // Utiliser un Set pour stocker les dates uniques sans tenir compte de l'heure
    Set<DateTime> uniqueDates = {};

    // Ajouter chaque date d'enregistrement unique au Set
    for (var record in userRecords) {
      uniqueDates.add(DateTime(record.creationDate!.year,
          record.creationDate!.month, record.creationDate!.day));
    }

    // Convertir le Set en liste et trier par date
    List<DateTime> sortedDates = uniqueDates.toList()..sort();

    int tempConsecutiveRecords = 1;
    int consecutiveRecords = 0;
    DateTime lastDate = sortedDates.first;

    // Vérifier les jours consécutifs
    for (var i = 1; i < sortedDates.length; i++) {
      // Vérifier la différence de jours
      if (sortedDates[i].difference(lastDate).inDays == 1) {
        tempConsecutiveRecords++;
      } else {
        consecutiveRecords = max(consecutiveRecords, tempConsecutiveRecords);
        tempConsecutiveRecords = 1;
      }

      lastDate = sortedDates[i];
    }

    return consecutiveRecords;
  }

  void filterByTransportMethod(TransportMethod? transportMethod) {
    if (_selectedTransportMethodForFilter == transportMethod) {
      _selectedTransportMethodForFilter = null;
    } else {
      _selectedTransportMethodForFilter = transportMethod;
    }
    _filterRecords();
    notifyListeners();
  }

  void filterByType(RecordType? type) {
    if (_selectedTypeForFilter == type) {
      _selectedTypeForFilter = null;
    } else {
      _selectedTypeForFilter = type;
    }
    _filterRecords();
    notifyListeners();
  }

  void _filterRecords() {
    _filteredUserRecords = _userRecords.where((record) {
      final matchesTransportMethod =
          _selectedTransportMethodForFilter == null ||
              record.transportMethod == _selectedTransportMethodForFilter;

      final matchesType = _selectedTypeForFilter == null ||
          record.recordType == _selectedTypeForFilter;

      return matchesTransportMethod && matchesType;
    }).toList();

    notifyListeners();
  }
}
