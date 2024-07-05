import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/widgets/generic/custom_textfield.dart';

class TeamSettingsForm extends StatelessWidget {
  const TeamSettingsForm({
    Key? key,
    required TextEditingController teamNameController,
  })  : _teamNameController = teamNameController,
        super(key: key);

  final TextEditingController _teamNameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Confidentialité",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMaterialSwitch('Visible'),
            _buildMaterialSwitch('Publique'),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          "Informations de l\'équipe",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        const SizedBox(height: 8.0),
        CustomTextField(
          controller: _teamNameController,
          label: "Nom de l'équipe",
          isFlexible: false,
        ),
      ],
    );
  }

  Widget _buildMaterialSwitch(String title) {
    bool value = true; // Set initial value as needed

    return Row(
      children: [
        Text(title),
        Switch(
          value: value,
          onChanged: (newValue) {
            // Handle switch value change
          },
          activeColor: AppConstants.primaryColor,
        ),
      ],
    );
  }
}
