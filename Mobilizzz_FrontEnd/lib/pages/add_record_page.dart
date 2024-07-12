import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/widgets/generic/custom_combobox.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage(
      {super.key, this.preselectedTeamId, required this.changeTabIndex});

  final int? preselectedTeamId;
  final Function(int) changeTabIndex;

  @override
  AddRecordPageState createState() => AddRecordPageState();
}

class AddRecordPageState extends State<AddRecordPage> {
  late User _user;

  // Form
  final _formKey = GlobalKey<FormState>();
  Team? _selectedTeam;
  late String _selectedTransportMethod;
  late String _selectedType;
  double _distance = 15;

  @override
  void initState() {
    super.initState();
    _selectedTransportMethod = AppConstants.transportMethods[0];
    _selectedType = AppConstants.types[0];
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    _user = authProvider.user!;
  }

  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enregistrement en cours...')),
      );
      Record newRecord = Record(
          distance: _distance,
          transportMethod:
              AppConstants.transportMethodValues[_selectedTransportMethod]!,
          type: AppConstants.typeValues[_selectedType]!,
          teamId: _selectedTeam?.id ?? 0,
          userId: _user.id);

      Provider.of<RecordProvider>(context, listen: false)
          .addRecord(newRecord, context)
          .then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Trajet ajouté avec succès')),
          );
          if (context.mounted) {
            _selectedTeam =
                null; // Reset selected team to avoid a weird bug when opening team admin page
            widget.changeTabIndex(0);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Erreur lors de l'ajout du trajet")),
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      });
    }
  }

  Widget _buildTransportMethodButton(String method, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTransportMethod = method;
        });
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: _selectedTransportMethod == method
                ? AppConstants.primaryColor
                : Colors.grey,
            size: 40.0,
          ),
          Text(method)
        ],
      ),
    );
  }

  Widget _buildTypeButton(String type, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      child: Column(
        children: [
          Icon(
            icon,
            color:
                _selectedType == type ? AppConstants.primaryColor : Colors.grey,
            size: 40.0,
          ),
          Text(type)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Ajouter un nouveau trajet'),
        backgroundColor: AppConstants.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<TeamProvider>(
          builder: (context, teamProvider, child) {
            return Form(
              key: _formKey, // Ensure the key is attached here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomComboBox<Team>(
                    label: "Team",
                    value: _selectedTeam,
                    items: teamProvider.teamsForUser.map((team) {
                      return DropdownMenuItem<Team>(
                        value: team,
                        child: Text(team.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTeam = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select a team.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text("Type de trajet", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTypeButton("Mission", Icons.work),
                      _buildTypeButton("Travail", Icons.home_work),
                      _buildTypeButton("Privé", Icons.home),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Text("Moyen de transport",
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTransportMethodButton(
                          "Marche", Icons.directions_walk),
                      _buildTransportMethodButton(
                          "2 Roues", Icons.directions_bike),
                      _buildTransportMethodButton("Bus", Icons.directions_bus),
                      _buildTransportMethodButton(
                          "Co-Voit", Icons.directions_car),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Distance: ${_distance.toStringAsFixed(0)} km',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Slider(
                    value: _distance,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: _distance.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _distance = value;
                      });
                    },
                    activeColor: AppConstants.primaryColor,
                  ),
                  CustomElevatedButton(
                    onPressed: _handleFormSubmit,
                    label: "Sauvegarder",
                    width: double.infinity,
                    color: AppConstants.primaryColor,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
