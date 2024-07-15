import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/enums/enums.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/utlis/utils.dart';
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
  late TransportMethod _selectedTransportMethod;
  late RecordType _selectedRecordType;
  double _distance = 15;

  final Team forMeTeam = const Team(
      id: null,
      name: "Pour moi",
      admins: [],
      companyId: 0,
      isHidden: false,
      isPrivate: false);

  @override
  void initState() {
    super.initState();
    _selectedTransportMethod = TransportMethod.walk;
    _selectedRecordType = RecordType.work;
    _selectedTeam = forMeTeam;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _user = authProvider.user!;
  }

  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enregistrement en cours...')),
      );
      Record newRecord = Record(
          distance: _distance,
          transportMethod: _selectedTransportMethod,
          teamId: _selectedTeam?.id ?? null,
          recordType: _selectedRecordType,
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

  Widget _buildTransportMethodButton(TransportMethod method, IconData icon) {
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
          Text(getTransportMethodString(method))
        ],
      ),
    );
  }

  Widget _buildTypeButton(RecordType type, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRecordType = type;
        });
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: _selectedRecordType == type
                ? AppConstants.primaryColor
                : Colors.grey,
            size: 40.0,
          ),
          Text(getRecordTypeString(type))
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
                    items: [
                      DropdownMenuItem<Team>(
                        value: forMeTeam,
                        child: const Text("Pour moi"),
                      ),
                      ...teamProvider.teamsForUser.map((team) {
                        return DropdownMenuItem<Team>(
                          value: team,
                          child: Text(team.name),
                        );
                      }),
                    ],
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
                      _buildTypeButton(
                          RecordType.work, AppConstants.recordTypeWorkIcon),
                      _buildTypeButton(RecordType.mission,
                          AppConstants.recordTypeMissionIcon),
                      _buildTypeButton(RecordType.private,
                          AppConstants.recordTypePrivateIcon),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Text("Moyen de transport",
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTransportMethodButton(TransportMethod.walk,
                          AppConstants.transportMethodWalkIcon),
                      _buildTransportMethodButton(TransportMethod.bike,
                          AppConstants.transportMethodBikeIcon),
                      _buildTransportMethodButton(TransportMethod.bus,
                          AppConstants.transportMethodBusIcon),
                      _buildTransportMethodButton(TransportMethod.carpooling,
                          AppConstants.transportMethodCarpoolingIcon),
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
