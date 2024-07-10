import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/dialogs/transport_ranking_dialog.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:mobilizzz/widgets/generic/stat_box.dart';
import 'package:mobilizzz/models/record_model.dart' as custom;

class TeamStats extends StatelessWidget {
  final double totalKm;
  final double mostUsedTransportMethodDistance;
  final String mostUsedTransportMethodName;
  final List<custom.Record> teamRecords;

  const TeamStats(
      {Key? key,
      required this.totalKm,
      required this.mostUsedTransportMethodDistance,
      required this.mostUsedTransportMethodName,
      required this.teamRecords})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      TransportRankingDialog(records: teamRecords),
                );
              },
              child: StatBox(
                icon: Icon(
                  getTransportIcon(mostUsedTransportMethodName),
                  color: AppConstants.primaryColor,
                  size: 34.0,
                ),
                title: "Préféré",
                value:
                    "${mostUsedTransportMethodDistance.toStringAsFixed(0)} km",
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
            value: "${totalKm.toStringAsFixed(0)} km",
          ),
          const StatBox(
            icon: Icon(
              Icons.leaderboard,
              color: AppConstants.primaryColor,
              size: 34.0,
            ),
            title: "Classement",
            value: "#3",
          ),
        ],
      ),
    );
  }
}
