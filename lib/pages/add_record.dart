import 'package:flutter/material.dart';
import 'package:mobilizzz/models/team_model.dart'; // Add this package

// Assuming you have models for TransportMethod and Team

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key});

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  double _distance = 0.0;
  DateTime _selectedDate = DateTime.now();
  String _selectedTransportMethod = '';
  Team? _selectedTeam;
  List<String> _transportMethods = []; 
  List<Team> _teams = []; // Replace with your teams

  @override
  void initState() {
    super.initState();
    // Fetch transport methods (replace with your logic)
    _transportMethods = ['Walking', 'Cycling', 'Running', 'Bus', 'Carpool']; // Example transport methods
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Record'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Slider(
              value: _distance,
              min: 0.0,
              max: 100.0, // Adjust max value as needed
              divisions: 10, // Number of divisions for the slider
              label: 'Distance (km): ${_distance.toStringAsFixed(1)}',
              onChanged: (newValue) {
                setState(() {
                  _distance = newValue;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text('Date:'),
                const SizedBox(width: 8.0),
                TextButton(
                  onPressed: () {
                  },
                  child: Text(_selectedDate.toIso8601String().split('T')[0]), // Format date only
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            const SizedBox(height: 16.0),
            DropdownButtonFormField<Team>(
              value: _selectedTeam,
              hint: const Text('Select Team'),
              items: _teams.map((Team team) => DropdownMenuItem<Team>(
                value: team,
                child: Text(team.name),
              )).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedTeam = newValue;
                });
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Validate and save record (replace with your logic)
                if (_distance > 0.0 && _selectedTransportMethod != null && _selectedTeam != null) {
                  // Save record using _distance, _selectedDate, _selectedTransportMethod, _selectedTeam
                  // ...
                  Navigator.pop(context); // Assuming you want to pop back after saving
                } else {
                  // Show error message if required fields are not filled
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all required fields.')),
                  );
                }
              },
              child: const Text('Save Record'),
            ),
          ],
        ),
      ),
    );
  }
}
