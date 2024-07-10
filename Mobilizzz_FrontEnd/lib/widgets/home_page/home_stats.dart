import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/dialogs/transport_ranking_dialog.dart';
import 'package:mobilizzz/models/record_model.dart';
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
    double maxDistance = 0;
    userRecords.forEach((record) {
      if (record.distance > maxDistance) {
        mostUsedTransport = record.transportMethod;
        maxDistance = record.distance;
      }
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => TransportRankingDialog(
                    records: userRecords,
                  ),
                );
              },
              child: StatBox(
                icon: const Icon(
                  Icons.directions_bike,
                  color: AppConstants.primaryColor,
                  size: 34.0,
                ),
                title: "Préféré",
                value: "${maxDistance.toStringAsFixed(0)} km",
              ),
            ),
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
          const StatBox(
            icon: Icon(
              Icons.calendar_today,
              color: AppConstants.primaryColor,
              size: 34.0,
            ),
            title: "Consécutif",
            value: "8 jours", // Replace with dynamic value
          ),
        ],
      ),
    );
  }
}
