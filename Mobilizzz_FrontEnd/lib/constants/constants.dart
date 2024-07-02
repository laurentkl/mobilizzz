import 'dart:ui';

import 'package:flutter/material.dart';

class AppConstants {
  // Example API URL constant
  static const String apiUrl = 'http://10.0.10.46:5169';
  // static const String apiUrl = 'http://localhost:5169';
  // static const String apiUrl = 'http://192.168.0.99:5169';
  // static const String apiUrl = 'http://10.0.10.55:5169';

  // Theme
  // static const Color primaryColor = Color(0xFF043aff);
  static const Color primaryColor = Color(0xFFB1AFFF);
  static const Color secondaryColor = Color(0xFFB1AFFF);
  static const Color inactiveColor = Colors.grey;
  static const Color backgroundColor = Colors.white;
  static const Color heading1Color = Colors.black;
  static const Color heading2Color = Color(0xFFFFE6E6);
  static const Color textColor = Colors.black54;
  static const Color contrastTextColor = Colors.white;

  // FontSize
  static const double rowFontSize = 14;

  static const List<String> types = ["Mission", "Travail", "Personnel"];
  static const List<String> transportMethods = [
    "Marche",
    "Vélo",
    "Bus",
    "Voiture"
  ];
}
