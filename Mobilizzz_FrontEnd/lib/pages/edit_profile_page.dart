import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/dialogs/generic_confirmation_dialog.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/user_provider.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';
import 'package:mobilizzz/widgets/generic/custom_textfield.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _firstNameController =
        TextEditingController(text: authProvider.user?.firstName ?? "");
    _lastNameController =
        TextEditingController(text: authProvider.user?.lastName ?? "");
    _emailController =
        TextEditingController(text: authProvider.user?.email ?? "");
    _usernameController =
        TextEditingController(text: authProvider.user?.userName ?? "");
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void _handleDeleteAccount() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericConfirmationDialog(
          title: 'Confirmation',
          content: 'Voulez-vous vraiment supprimer votre compte ?',
          confirmText: 'Supprimer',
          onConfirm: () async {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);

            try {
              await userProvider.deleteUser(authProvider.user!.id);
              authProvider.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Votre compte est définitivement supprimé!"),
                ),
              );
              Navigator.pop(context); // Close the dialog
              if (context.mounted) context.go('/login');
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text("Erreur lors de la suppression du compte: $error"),
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      try {
        User updatedUser;

        // Check if password fields are empty or unchanged
        if (_passwordController.text.isEmpty) {
          updatedUser = User(
            id: authProvider.user!.id,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            userName: _usernameController.text,
            password: null, // Send null if password is not modified
          );
        } else {
          updatedUser = User(
            id: authProvider.user!.id,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            userName: _usernameController.text,
            password: _passwordController.text,
          );
        }

        await userProvider.updateUser(
            authProvider.user!.id, updatedUser, context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        if (context.mounted) Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editer votre profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _firstNameController,
                label: 'First Name',
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: _lastNameController,
                label: 'Last Name',
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: _usernameController,
                label: 'Username',
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: _passwordController,
                label: 'Nouveau mot de passe',
                obscureText: true,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (value.length < 8) {
                      return 'Le mot de passe doit contenir au moins 8 caractères';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: _confirmPasswordController,
                label: 'Confirmer mot de passe',
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              CustomElevatedButton(
                onPressed: _handleSubmit,
                width: double.infinity,
                label: 'Sauvegarder',
                color: AppConstants.primaryColor,
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: _handleDeleteAccount,
                child: const Text(
                  "Supprimer mon compte",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
