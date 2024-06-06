import 'package:flutter/material.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                'Team Total Km',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                totalKm.toString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                'Team Bike Km',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                bikeKm.toString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
