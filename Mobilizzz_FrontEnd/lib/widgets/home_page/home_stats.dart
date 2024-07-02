import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:mobilizzz/widgets/generic/stat_box.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({Key? key, required this.userRecords}) : super(key: key);

  final List<Record> userRecords;

  @override
  Widget build(BuildContext context) {
    var totalKm =
        userRecords.fold(0, (sum, record) => sum + record.distance.toInt());

    // Find the most used transport method and its total distance
    String mostUsedTransport = '';
    int maxDistance = 0;
    userRecords.forEach((record) {
      if (record.distance.toInt() > maxDistance) {
        mostUsedTransport = record.transportMethod;
        maxDistance = record.distance.toInt();
      }
    });

    // IconData transportIcon = getTransportIcon(mostUsedTransport);
    IconData transportIcon = getTransportIcon("bike");

    // Calculate the streak of consecutive days with records
    int consecutiveDays = 8;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          StatBox(
            icon: Icon(
              transportIcon,
              color: AppConstants.primaryColor,
              size: 34.0,
            ),
            title: "Préféré",
            // value: "$maxDistance km",
            value: "93 km",
          ),
          StatBox(
            icon: const Icon(
              Icons.add_road,
              color: AppConstants.primaryColor,
              size: 34.0,
            ),
            title: "Total",
            value: "$totalKm km",
          ),
          StatBox(
            icon: const Icon(
              Icons.calendar_today,
              color: AppConstants.primaryColor,
              size: 34.0,
            ),
            title: "Consécutif",
            value: "$consecutiveDays jours",
          ),
        ],
      ),
    );
  }
}
