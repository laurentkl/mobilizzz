import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/enums/enums.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:mobilizzz/widgets/generic/transport_ranking_row.dart';

class TransportRankingDialog extends StatelessWidget {
  final List<Record> records;

  const TransportRankingDialog({
    Key? key,
    required this.records,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate total distance per transport method
    Map<TransportMethod, double> transportDistances = {};
    for (var record in records) {
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
                transportMethod: AppConstants.transportMethodNamesToFrench[
                        sortedTransports[i].key] ??
                    '',
                totalDistance: sortedTransports[i].value ?? 0,
                rank: i + 1,
                icon: Icon(
                  getTransportMethodIcon(sortedTransports[i].key),
                  color: AppConstants.contrastTextColor,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
