import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on,
              size: 100.0, // Taille de l'icône
              color: AppConstants.primaryColor),
          Column(
            children: [
              Text(
                'Mobilitizzz', // Remplacez par le texte que vous voulez
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Se déplacer autrement', // Remplacez par le texte que vous voulez
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
