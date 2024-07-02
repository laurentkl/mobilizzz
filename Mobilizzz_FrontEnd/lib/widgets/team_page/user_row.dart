import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/user_model.dart';

class UserRow extends StatelessWidget {
  const UserRow({
    super.key,
    required this.user,
    required this.teamId,
  });

  final User user;
  final int teamId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppConstants.primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                user.firstName ?? "",
                style: const TextStyle(
                    color: AppConstants.contrastTextColor,
                    fontSize: AppConstants.rowFontSize),
              ),
            ),
            Text(
              '${user.getTotalDistanceByTeam(teamId).toStringAsFixed(1)} km',
              style: const TextStyle(
                  color: AppConstants.contrastTextColor,
                  fontSize: AppConstants.rowFontSize),
            ),
          ],
        ),
      ),
    );
  }
}
