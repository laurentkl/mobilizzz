import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/utlis/utils.dart';

class TransportRankingRow extends StatelessWidget {
  const TransportRankingRow({
    Key? key,
    required this.transportMethod,
    required this.totalDistance,
    required this.rank,
    required this.icon,
  }) : super(key: key);

  final String transportMethod;
  final double totalDistance;
  final int rank;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppConstants.primaryColor,
      ),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '#$rank',
                style: const TextStyle(
                    color: AppConstants.contrastTextColor,
                    fontSize: AppConstants.rowFontSize),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(flex: 1, child: icon),
            Expanded(
              flex: 3,
              child: Text(
                transportMethod,
                style: const TextStyle(
                    color: AppConstants.contrastTextColor,
                    fontSize: AppConstants.rowFontSize),
                maxLines: 1,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    totalDistance.toStringAsFixed(0),
                    style: const TextStyle(
                        color: AppConstants.contrastTextColor,
                        fontSize: AppConstants.rowFontSize),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'km',
                    style: TextStyle(
                        color: AppConstants.contrastTextColor,
                        fontSize: AppConstants.rowFontSize),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
