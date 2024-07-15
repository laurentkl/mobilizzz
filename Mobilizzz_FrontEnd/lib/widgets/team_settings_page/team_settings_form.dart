import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/widgets/generic/custom_textfield.dart';

class TeamSettingsForm extends StatelessWidget {
  const TeamSettingsForm({
    Key? key,
    required TextEditingController teamNameController,
    required this.isHidden,
    required this.isPrivate,
    required this.onVisibilityChanged,
    required this.onPublicChanged,
    required this.isAdmin,
  })  : _teamNameController = teamNameController,
        super(key: key);

  final TextEditingController _teamNameController;
  final bool isHidden;
  final bool isPrivate;
  final ValueChanged<bool> onVisibilityChanged;
  final ValueChanged<bool> onPublicChanged;
  final bool isAdmin;

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
            _buildMaterialSwitch(
                'Visible', !isHidden, onVisibilityChanged, isAdmin),
            _buildMaterialSwitch(
                'Publique', !isPrivate, onPublicChanged, isAdmin),
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
          isEnabled: isAdmin,
          controller: _teamNameController,
          label: "Nom de l'équipe",
          isFlexible: false,
        ),
      ],
    );
  }

  Widget _buildMaterialSwitch(
      String title, bool value, ValueChanged<bool> onChanged, bool isEnabled) {
    return Row(
      children: [
        Text(title),
        Switch(
          value: value,
          onChanged: isEnabled ? onChanged : null,
          activeColor: AppConstants.primaryColor,
        ),
      ],
    );
  }
}
