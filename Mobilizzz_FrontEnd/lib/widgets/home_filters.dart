import 'package:flutter/material.dart';

class TransportFilter extends StatelessWidget {
  final Function(String) onFilterSelected;

  const TransportFilter({Key? key, required this.onFilterSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.directions_bus),
          onPressed: () => onFilterSelected('bus'),
        ),
        IconButton(
          icon: Icon(Icons.directions_bike),
          onPressed: () => onFilterSelected('bike'),
        ),
        IconButton(
          icon: Icon(Icons.directions_walk),
          onPressed: () => onFilterSelected('walk'),
        ),
        // Ajoutez d'autres icônes pour les autres moyens de transport si nécessaire
      ],
    );
  }
}
