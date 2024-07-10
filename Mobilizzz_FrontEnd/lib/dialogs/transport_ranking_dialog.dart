import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:mobilizzz/widgets/generic/transport_ranking_row.dart';

class TransportRankingDialog extends StatelessWidget {
  final List<Record> userRecords;

  const TransportRankingDialog({
    Key? key,
    required this.userRecords,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate total distance per transport method
    Map<String, double> transportDistances = {};
    for (var record in userRecords) {
      transportDistances.update(
        record.transportMethod,
        (value) => value + record.distance,
        ifAbsent: () => record.distance,
      );
    }

    // Sort transport methods by total distance
    var sortedTransports = transportDistances.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return AlertDialog(
      title: const Text('Classement par transports'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < sortedTransports.length; i++)
              TransportRankingRow(
                transportMethod: AppConstants
                    .transportMethods[sortedTransports[i].key]!,
                totalDistance: sortedTransports[i].value!,
                rank: i + 1,
                icon: Icon(
                getTransportIcon(sortedTransports[i].key),
                color: AppConstants.contrastTextColor,
                size: 24,
              ),,
              ),
          ],
        ),
      ),
    );
  }
}
