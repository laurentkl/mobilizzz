import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';
import 'package:mobilizzz/widgets/generic/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddTeamDialog extends StatefulWidget {
  AddTeamDialog({Key? key}) : super(key: key);

  @override
  _AddTeamDialogState createState() => _AddTeamDialogState();
}

class _AddTeamDialogState extends State<AddTeamDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teamNameController = TextEditingController();
  final ValueNotifier<bool> _isPrivateNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isHiddenNotifier = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _teamNameController.dispose();
    _isPrivateNotifier.dispose();
    _isHiddenNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ajouter une équipe'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              label: "Nom de l'équipe",
              controller: _teamNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a team name';
                }
                return null;
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isPrivateNotifier,
              builder: (context, value, child) {
                return SwitchListTile(
                  title: Text('Ouverte au public'),
                  value: value,
                  onChanged: (bool newValue) {
                    _isPrivateNotifier.value = newValue;
                  },
                  activeColor: AppConstants.primaryColor,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isHiddenNotifier,
              builder: (context, value, child) {
                return SwitchListTile(
                  title: Text('Visible dans les classements'),
                  value: value,
                  onChanged: (bool newValue) {
                    _isHiddenNotifier.value = newValue;
                  },
                  activeColor: AppConstants.primaryColor,
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Annuler'),
        ),
        CustomElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              var teamProvider =
                  Provider.of<TeamProvider>(context, listen: false);
              var authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              try {
                var user = authProvider.user;
                var team = Team(
                  name: _teamNameController.text,
                  admins: [user!],
                  companyId: 1,
                  isHidden: _isHiddenNotifier.value,
                  isPrivate: _isPrivateNotifier.value,
                );
                var newTeam = await teamProvider.createTeam(team, user.id);
                teamProvider.setCurrentTeamFromId(newTeam.id!);

                if (context.mounted) {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.toString())),
                );
              }
            }
          },
          label: "Ajouter",
          color: AppConstants.primaryColor,
        ),
      ],
    );
  }
}
