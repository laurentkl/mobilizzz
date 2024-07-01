import 'dart:ui';

class AppConstants {
  // Example API URL constant
  static const String apiUrl = 'http://10.0.10.46:5169';
  // static const String apiUrl = 'http://localhost:5169';
  // static const String apiUrl = 'http://192.168.0.99:5169';
  // static const String apiUrl = 'http://10.0.10.55:5169';

  // Theme
  static const Color primaryColor = Color(0xFF043aff);

  static const List<String> types = ["Mission", "Travail", "Personnel"];
  static const List<String> transportMethods = [
    "Marche",
    "Vélo",
    "Bus",
    "Voiture"
  ];
}
