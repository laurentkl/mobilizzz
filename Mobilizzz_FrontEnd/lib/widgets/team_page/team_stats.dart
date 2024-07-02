import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/widgets/generic/stat_box.dart';

class TeamStats extends StatelessWidget {
  final double totalKm;
  final double bikeKm;

  const TeamStats({
    Key? key,
    required this.totalKm,
    required this.bikeKm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
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
              Icons.directions_bike,
              color: AppConstants.primaryColor,
              size: 34.0,
            ),
            title: "Préféré",
            value: "399 km",
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
