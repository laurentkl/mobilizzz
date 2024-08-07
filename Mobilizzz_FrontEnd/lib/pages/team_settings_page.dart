import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/dialogs/generic_confirmation_dialog.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:mobilizzz/widgets/generic/custom_elevated_button.dart';
import 'package:mobilizzz/widgets/team_settings_page/managed_user_list.dart';
import 'package:mobilizzz/widgets/team_settings_page/team_settings_form.dart';
import 'package:provider/provider.dart';

class TeamSettingsPage extends StatefulWidget {
  final Team team;
  final bool isAdmin;

  const TeamSettingsPage({Key? key, required this.team, required this.isAdmin})
      : super(key: key);

  @override
  _TeamSettingsPageState createState() => _TeamSettingsPageState();
}

class _TeamSettingsPageState extends State<TeamSettingsPage> {
  late final List<User> _pendingUsers = [];
  late final TextEditingController _teamNameController;
  late bool _isHidden;
  late bool _isPrivate;

  Future<void> _approveJoinTeam(
      User requestUser, bool isApproved, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericConfirmationDialog(
          title: 'Confirmation',
          content: isApproved
              ? 'Voulez-vous approuver la demande de ${requestUser.userName} pour rejoindre l\'équipe ?'
              : 'Voulez-vous rejeter la demande de ${requestUser.userName} pour rejoindre l\'équipe ?',
          confirmText: isApproved ? 'Approuver' : 'Rejeter',
          onConfirm: () async {
            final teamProvider =
                Provider.of<TeamProvider>(context, listen: false);
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);

            try {
              await teamProvider.approveTeamRequest(
                authProvider.user!.id,
                widget.team.id!,
                requestUser.id,
                isApproved,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Requête utilisateur traitée avec succès'),
                ),
              );
              setState(() {
                _pendingUsers.remove(requestUser);
              });
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Erreur lors du traitement de la requête'),
                ),
              );
            }
            Navigator.pop(context); // Ferme le dialogue après l'action
          },
        );
      },
    );
  }

  Future<void> _leaveTeam(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GenericConfirmationDialog(
            title: 'Confirmation',
            content: 'Voulez-vous vraiment quitter l\'équipe ?',
            confirmText: 'Quitter',
            onConfirm: () async {
              final teamProvider =
                  Provider.of<TeamProvider>(context, listen: false);
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              final userId = authProvider.user!.id;
              final teamId = widget.team.id!;

              try {
                await teamProvider.leaveTeam(teamId, userId, userId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Vous avez quitté l\'équipe avec succès')),
                );
                Navigator.pop(context); // Go back to the previous screen
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Erreur lors de la sortie de l\'équipe: $error')),
                );
              }
            },
          );
        });
  }

  void _fetchTeamData() async {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await teamProvider.fetchTeamsForUser(authProvider.user!.id);
  }

  @override
  void initState() {
    super.initState();
    _fetchTeamData();
    _teamNameController = TextEditingController(text: widget.team.name);
    _isHidden = widget.team.isHidden;
    _isPrivate = widget.team.isPrivate;
  }

  void _saveSettings() async {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    var updatedTeam = Team(
        id: widget.team.id,
        name: _teamNameController.text,
        isHidden: _isHidden,
        isPrivate: _isPrivate,
        companyId: widget.team.companyId);

    try {
      await teamProvider.updateTeam(updatedTeam, authProvider.user!.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Paramètres de l\'équipe mis à jour avec succès')),
        );
        Navigator.pop(context);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Erreur lors de la sauvegarde des paramètres')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        title: const Text(
          "Paramètres de l'équipe",
          style: TextStyle(color: AppConstants.primaryColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_rounded),
            onPressed: () {
              String contentToCopy =
                  'www.mobilitizzz.com/invite/${widget.team.id}';
              FlutterClipboard.copy(contentToCopy).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("Lien d'invitation copié dans le presse papier"),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: Consumer<TeamProvider>(
        builder: (context, teamProvider, child) {
          final team = teamProvider.teamsForUser
              .firstWhere((team) => team.id == widget.team.id);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TeamSettingsForm(
                    teamNameController: _teamNameController,
                    isHidden: _isHidden,
                    isPrivate: _isPrivate,
                    onVisibilityChanged: (value) {
                      setState(() {
                        _isHidden = !value;
                      });
                    },
                    onPublicChanged: (value) {
                      setState(() {
                        _isPrivate = !value;
                      });
                    },
                    isAdmin: widget.isAdmin,
                  ),
                  const SizedBox(height: 16.0),
                  if (widget.isAdmin)
                    Expanded(
                      flex: 1,
                      child: ManagedUsersList(
                        team: team,
                        approveCallback: _approveJoinTeam,
                      ),
                    ),
                  if (widget.isAdmin) const SizedBox(height: 16.0),
                  if (widget.isAdmin)
                    CustomElevatedButton(
                      onPressed: _saveSettings,
                      label: "Sauvegarder",
                      color: AppConstants.primaryColor,
                    ),
                  if (!widget
                      .isAdmin) // Show leave button only if the user is not an admin
                    CustomElevatedButton(
                      onPressed: () => _leaveTeam(context),
                      label: "Quitter l'équipe",
                      color: Colors.red,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
