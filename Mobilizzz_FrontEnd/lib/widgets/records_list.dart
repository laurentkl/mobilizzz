import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/enums/enums.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:intl/intl.dart';

class RecordsList extends StatelessWidget {
  final List<Record> userRecords;

  const RecordsList({super.key, required this.userRecords});

  IconData _getTransportIcon(String transportMethod) {
    switch (transportMethod) {
      case 'bike':
        return Icons.directions_bike;
      case 'bus':
        return Icons.directions_bus;
      default:
        return Icons.directions_walk;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'mission':
        return Icons.track_changes_outlined;
      case 'personnel':
        return Icons.favorite;
      case 'travail':
        return Icons.alarm;
      default:
        return Icons.directions_walk;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: userRecords.length,
        itemBuilder: (context, index) {
          final record = userRecords[index];
          String formattedDate = DateFormat('dd/MM/yyyy')
              .format(record.creationDate ?? DateTime.now());
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white54,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Delhez',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${record.distance} km',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          ' $formattedDate',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        _getTransportIcon(record.transportMethod),
                        color: Colors.white,
                        size: 24,
                      ),
                      Icon(
                        _getTypeIcon(record.type),
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
