import 'package:flutter/material.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:provider/provider.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key});

  @override
  AddRecordPageState createState() => AddRecordPageState();
}

class AddRecordPageState extends State<AddRecordPage> {
  late User _user;

  // Form 
  final _formKey = GlobalKey<FormState>();
  Team? _selectedTeam;
  final List<String> transportMethods = ["Walking", "Cycling", "Bus"]; // Sample data
  late String _selectedTransportMethod;
  double _distance = 0;

  @override
  void initState() {
    super.initState();
    _selectedTransportMethod = transportMethods[0]; // Initialize with the first element
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _user = authProvider.user!;
  }

    // Function to be called every time the state changes
  void _onStateChanged() {
    // Implement any logic you want to perform on state change
    print("State changed: Transport Method: $_selectedTransportMethod, Distance: $_distance");
  }

  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission (e.g., save record)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      Record newRecord = Record(distance: _distance, transportMethod: _selectedTransportMethod, teamId: _selectedTeam?.id ?? 0, userId: _user.id);

        Provider.of<RecordProvider>(context, listen: false).addRecord(newRecord).then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Record added successfully')),
          );
          Navigator.pop(context); // Close the page after submission
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add record')),
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Record'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<Team>(
                value: _selectedTeam,
                decoration: const InputDecoration(labelText: "Team"),
                items: _user.teams.map((team) {
                  return DropdownMenuItem<Team>(
                    value: team,
                    child: Text(team.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTeam = value;
                    _onStateChanged();
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Please select a team.";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: transportMethods[0],
                decoration: const InputDecoration(labelText: "Transport Method"),
                items: transportMethods.map((transportMethod) {
                  return DropdownMenuItem<String>(
                    value: transportMethod,
                    child: Text(transportMethod),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTransportMethod = value!;
                    _onStateChanged();
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a transport method.";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Distance"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter distance.";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _distance = double.tryParse(value) ?? 0;
                    _onStateChanged();
                  });
                },
                // onSaved: (value) {
                //   _distance = value! as double;
                // },
              ),
              ElevatedButton(
                onPressed: () {
                  _handleFormSubmit();
                },
                child: const Text('Save Record'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
