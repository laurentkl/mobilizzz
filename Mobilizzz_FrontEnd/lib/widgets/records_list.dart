import 'package:flutter/material.dart';
import 'package:mobilizzz/models/record_model.dart'; // Assuming you have a Record model defined

class RecordsList extends StatelessWidget {
  final List<Record> records; // Accepting a list of records as a parameter

  const RecordsList({super.key, required this.records});

  IconData _getTransportIcon(String transportMethod) {
    switch (transportMethod.toLowerCase()) {
      case 'bike':
        return Icons.directions_bike;
      case 'bus':
        return Icons.directions_bus;
      // Add more cases for other transport methods if needed
      default:
        return Icons.directions_walk; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.amber, // Single color for the record card
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Icon(
                          _getTransportIcon(record.transportMethod),
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 8), // Add spacing between icon and text
                        Text(
                          record.transportMethod,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${record.distance} km',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
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
