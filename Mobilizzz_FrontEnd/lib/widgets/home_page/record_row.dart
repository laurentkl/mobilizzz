import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:provider/provider.dart';

class RecordRow extends StatelessWidget {
  const RecordRow({
    Key? key,
    required this.record,
    required this.formattedDate,
  }) : super(key: key);

  final Record record;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    var teamProvider = Provider.of<TeamProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppConstants.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Team Name
            Expanded(
              flex: 2,
              child: AutoSizeText(
                teamProvider.getUserTeamFromId(record.teamId)?.name ??
                    "No Team",
                style: const TextStyle(
                    color: AppConstants.contrastTextColor,
                    fontSize: AppConstants.rowFontSize),
                maxLines: 1,
              ),
            ),
            // Distance and Date
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    record.distance.toStringAsFixed(0).padLeft(4, ' '),
                    style: const TextStyle(
                        color: AppConstants.contrastTextColor,
                        fontSize: AppConstants.rowFontSize),
                  ),
                  const Text(
                    ' km',
                    style: TextStyle(
                        color: AppConstants.contrastTextColor,
                        fontSize: AppConstants.rowFontSize),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                        color: AppConstants.contrastTextColor,
                        fontSize: AppConstants.rowFontSize),
                  ),
                ],
              ),
            ),
            // Icons
            Row(
              children: [
                Icon(
                  getTransportIcon(record.transportMethod),
                  color: AppConstants.contrastTextColor,
                  size: 24,
                ),
                const SizedBox(width: 4),
                Icon(
                  getTypeIcon(record.type),
                  color: AppConstants.contrastTextColor,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
