import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';

class StatBox extends StatelessWidget {
  const StatBox({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    this.backgroundColor = Colors.white, // Default background color
  }) : super(key: key);

  final Widget icon;
  final String title;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          icon,
          const SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                title,
                style: const TextStyle(
                  color: AppConstants.heading1Color,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              AutoSizeText(
                value,
                style: const TextStyle(
                  color: AppConstants.textColor,
                  fontSize: 16.0,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
