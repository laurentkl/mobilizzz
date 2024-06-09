import 'package:flutter/material.dart';

class AddTeamDialog extends StatelessWidget {

  AddTeamDialog({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String _teamName = '';

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
          onSaved: (value) {
            _teamName = value!;
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.pop(context);
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
