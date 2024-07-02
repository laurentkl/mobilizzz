import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/pages/edit_profile_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key, required this.userRecords}) : super(key: key);

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

    IconData transportIcon = getTransportIcon(mostUsedTransport);

    // Calculate the streak of consecutive days with records
    int consecutiveDays = 8;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Icon(
                  transportIcon,
                  color: AppConstants.primaryColor,
                  size: 34.0,
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Préféré",
                      style: TextStyle(
                        color: AppConstants.heading1Color,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "80 km",
                      // "$maxDistance km",
                      style: const TextStyle(
                        color: AppConstants.textColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Icon(
                  Icons.directions_walk,
                  color: AppConstants.primaryColor,
                  size: 34.0,
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      "Total",
                      style: TextStyle(
                        color: AppConstants.heading1Color,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      "$totalKm km",
                      style: const TextStyle(
                        color: AppConstants.textColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: AppConstants.primaryColor,
                  size: 34.0,
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      "Jours de suite",
                      style: TextStyle(
                        color: AppConstants.heading1Color,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      "$consecutiveDays jours",
                      style: const TextStyle(
                        color: AppConstants.textColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
