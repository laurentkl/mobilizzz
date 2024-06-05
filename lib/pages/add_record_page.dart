import 'package:flutter/material.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:provider/provider.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key});

  @override
  AddRecordPageState createState() => AddRecordPageState();
}

class AddRecordPageState extends State<AddRecordPage> {
  final _formKey = GlobalKey<FormState>();
  double _distance = 0;
  String _selectedTransportMethod = "";
  final List<String> transportMethods = ["Walking", "Cycling", "Bus"]; // Sample data

  @override
  void initState() {
    super.initState();
    _selectedTransportMethod = transportMethods[0]; // Initialize with the first element
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
      Record newRecord = Record(distance: _distance, transportMethod: _selectedTransportMethod, teamId: 1, userId: 1);

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
