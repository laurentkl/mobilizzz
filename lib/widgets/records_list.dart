import 'package:flutter/material.dart';
import 'package:mobilizzz/utlis/utils.dart';

class RecordsList extends StatelessWidget {
  const RecordsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadMockRecords(), // Assuming this function returns a Future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No records found'));
          } else {
            final records = snapshot.data!;
            return ListView.builder(
              // Show only the first 5 elements
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.tealAccent[100], // Single color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Less space
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            record.transportMethod,
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        Text(
                          '${record.distance} km',
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
