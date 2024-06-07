import 'package:flutter/material.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:provider/provider.dart';

class RecordsList extends StatefulWidget {
  const RecordsList({super.key});

  @override
  State<RecordsList> createState() => _RecordsListState();
}

class _RecordsListState extends State<RecordsList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RecordProvider>(context, listen: false).getAllRecords();
    });
  }

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
    return Scaffold(
      body: Consumer<RecordProvider>(
        builder: (context, value, _) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final records = value.records;
          return ListView.builder(
            // Show only the first 5 elements
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber, // Single color
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Less space
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Icon(
                              _getTransportIcon(record.transportMethod),
                              color: Colors.black,
                              size: 24,
                            ),
                            const SizedBox(
                                width: 8), // Add spacing between icon and text
                            Text(
                              record.transportMethod,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${record.distance} km',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
