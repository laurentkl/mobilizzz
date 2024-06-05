import 'package:flutter/material.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/utlis/utils.dart';
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
        },
      ),
    );
  }
}
