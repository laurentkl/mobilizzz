import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/pages/home_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key, this.preselectedTeamId});

  final int? preselectedTeamId;

  @override
  AddRecordPageState createState() => AddRecordPageState();
}

class AddRecordPageState extends State<AddRecordPage> {
  late User _user;

  // Form
  final _formKey = GlobalKey<FormState>();
  Team? _selectedTeam;
  final List<String> transportMethods = ["Marche", "Vélo", "Bus", "Voiture"];
  late String _selectedTransportMethod;
  final List<String> types = ["Mission", "Travail", "Personnel"];
  late String _selectedType;
  double _distance = 0;

  final Map<String, String> typeValues = {
    "Mission": "mission",
    "Travail": "work",
    "Personnel": "personal",
  };

  final Map<String, String> transportMethodValues = {
    "Marche": "walk",
    "Vélo": "bike",
    "Bus": "bus",
    "Voiture": "car",
  };

  @override
  void initState() {
    super.initState();
    _selectedTransportMethod = transportMethods[0];
    _selectedType = types[0];
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    _user = authProvider.user!;
    if (widget.preselectedTeamId != null) {
      _selectedTeam = teamProvider.teamsForUser
          .firstWhere((team) => team.id == widget.preselectedTeamId);
    }
  }

  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enregistrement en cours...')),
      );
      Record newRecord = Record(
          distance: _distance,
          transportMethod: transportMethodValues[_selectedTransportMethod]!,
          type: typeValues[_selectedType]!,
          teamId: _selectedTeam?.id ?? 0,
          userId: _user.id);

      Provider.of<RecordProvider>(context, listen: false)
          .addRecord(newRecord, context)
          .then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Trajet ajouté avec succès')),
          );
          // if (context.mounted) context.go('/home');
          if (context.mounted) {
            // Change the index of BottomNav using the GlobalKey
            final BottomNavState bottomNavState =
                context.findAncestorStateOfType<BottomNavState>()!;
            bottomNavState.changeTabIndex(0);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Erreur lors de l\'ajout du trajet")),
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
        child: Consumer<TeamProvider>(
          builder: (context, teamProvider, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<Team>(
                    value: _selectedTeam,
                    decoration: const InputDecoration(labelText: "Team"),
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
                  DropdownButtonFormField<String>(
                    value: types[0],
                    decoration:
                        const InputDecoration(labelText: "Type de trajet"),
                    items: types.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a transport method.";
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: transportMethods[0],
                    decoration:
                        const InputDecoration(labelText: "Transport Method"),
                    items: transportMethods.map((transportMethod) {
                      return DropdownMenuItem<String>(
                        value: transportMethod,
                        child: Text(transportMethod),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTransportMethod = value!;
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
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _handleFormSubmit();
                    },
                    child: const Text('Save Record'),
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
