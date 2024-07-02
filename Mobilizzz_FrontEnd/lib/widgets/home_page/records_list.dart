import 'package:flutter/material.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:intl/intl.dart';
import 'package:mobilizzz/widgets/home_page/record_row.dart';

class RecordsList extends StatelessWidget {
  final List<Record> userRecords;

  const RecordsList({super.key, required this.userRecords});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: userRecords.length,
      itemBuilder: (context, index) {
        final record = userRecords[index];
        String formattedDate = DateFormat('dd/MM/yyyy')
            .format(record.creationDate ?? DateTime.now());
        return RecordRow(record: record, formattedDate: formattedDate);
      },
    );
  }
}
