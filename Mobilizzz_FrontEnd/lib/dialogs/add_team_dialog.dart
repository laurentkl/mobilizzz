import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddTeamDialog extends StatelessWidget {
  AddTeamDialog({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String _teamName = ''; // Initialize _teamName

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Team'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Team Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a team name';
            }
            return null;
          },
          onChanged: (value) {
            // Update _teamName whenever the text changes
            _teamName = value;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              var teamProvider = Provider.of<TeamProvider>(context, listen: false);
              var authProvider = Provider.of<AuthProvider>(context, listen: false);
              Navigator.pop(context);
               try {
                var userId = authProvider.user!.id;
                var team = Team(name: _teamName, adminIds: [userId], companyId: 1);
                  await teamProvider.createTeam(team, userId);
                  if(context.mounted) Navigator.pop(context);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error.toString())),
                  );
                }
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
