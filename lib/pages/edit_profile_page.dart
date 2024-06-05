import 'package:flutter/material.dart';
import 'package:mobilizzz/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = "";
  String _lastName = "";

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _firstName = userProvider.users?.first.firstName ?? "";
    _lastName = userProvider.users?.first.lastName ?? ""; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _firstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name.';
                  }
                  return null;
                },
                onSaved: (newValue) => _firstName = newValue!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _lastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name.';
                  }
                  return null;
                },
                onSaved: (newValue) => _lastName = newValue!,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Update user data in UserProvider (replace with your logic)
                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    //userProvider.updateUser(_firstName, _lastName);
                    // Show success message or navigate back
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated successfully!')),
                    );
                    Navigator.pop(context); // Assuming you want to pop back after update
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
