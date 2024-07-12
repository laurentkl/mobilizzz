import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppConstants {
  // Example API URL constant
  // static const String apiUrl = 'http://10.0.1.158:5169';
  static const String apiUrl = 'http://localhost:5169';
  // static const String apiUrl = 'http://192.168.0.99:5169';
  // static const String apiUrl = 'http://10.0.1.190:5169';
  // static const String apiUrl = 'http://10.0.10.55:5169';

// --blue : #0439ff
// --lavande : #C2C7FF
// --corail : #ea515b
// --red : #e51e58
// --pink : #f19eeb
// --yellow : #ecfb81
// --green : #75CA6D
// --turquoise : #5dd8c9

  // Theme
  static const Color primaryColor = Color(0xFFB1AFFF);
  static const Color backgroundColor = Colors.white;
  static const Color secondaryColor = Color(0xFFB1AFFF);
  static const Color inactiveColor = Colors.grey;
  static const Color heading1Color = Colors.black;
  static const Color heading2Color = Color(0xFFFFE6E6);
  static const Color textColor = Colors.black54;
  static const Color contrastTextColor = Colors.white;

  // Final
  // static const Color primaryColor = Color(0xFFecfb81);
  // static const Color backgroundColor = Color(0xFF0439ff);
  // FontSize
  static const double rowFontSize = 14;

  static const List<String> types = ["Mission", "Travail", "Personnel"];
  static const List<String> transportMethods = [
    "Marche",
    "2 Roues",
    "Bus",
    "Co-Voit"
  ];

  static const Map<String, String> typeValues = {
    "Mission": "mission",
    "Travail": "work",
    "Privé": "personal",
  };

  static const Map<String, String> transportMethodValues = {
    "Marche": "walk",
    "2 Roues": "bike",
    "Bus": "bus",
    "Co-Voit": "carpooling",
  };

  static Map<String, String> transportMethodNamesToFrench = {
    for (var entry in AppConstants.transportMethodValues.entries)
      entry.value: entry.key
  };
}
