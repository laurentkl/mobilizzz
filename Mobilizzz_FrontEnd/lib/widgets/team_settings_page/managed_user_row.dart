import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/dialogs/generic_confirmation_dialog.dart';
import 'package:mobilizzz/models/team_model.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:provider/provider.dart';

class ManagedUserRow extends StatelessWidget {
  const ManagedUserRow({
    Key? key,
    required this.user,
    required this.team,
    required this.isPending,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  final User user;
  final Team team;
  final bool isPending;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  void _onActionSelected(String action, BuildContext context) {
    switch (action) {
      case 'eject':
        _ejectUser(context);
        break;
      case 'grantAdmin':
        _grantAdminRights(context);
        break;
      default:
        break;
    }
  }

  void _ejectUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericConfirmationDialog(
          title: 'Confirmation',
          content:
              'Voulez-vous vraiment éjecter ${user.userName} de l\'équipe ?',
          confirmText: 'Éjecter',
          onConfirm: () async {
            final teamProvider =
                Provider.of<TeamProvider>(context, listen: false);
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);
            final callerUserId = authProvider.user!.id;
            var teamId = teamProvider.currentTeam?.id!;

            try {
              await teamProvider.ejectUser(teamId!, user.id, callerUserId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("${user.userName} a été éjecté de l'équipe")),
              );
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Échec lors de la requête pour éjecter l'utilisateur: $error"),
                ),
              );
            }
            Navigator.pop(context); // Ferme le dialogue après l'action
          },
        );
      },
    );
  }

  void _grantAdminRights(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericConfirmationDialog(
          title: 'Confirmation',
          content:
              'Voulez-vous vraiment donner les droits d\'administration à ${user.userName} ?',
          confirmText: 'Confirmer',
          onConfirm: () async {
            final teamProvider =
                Provider.of<TeamProvider>(context, listen: false);
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);
            final callerUserId = authProvider.user!.id;
            var teamId = teamProvider.currentTeam?.id!;

            try {
              await teamProvider.grantAdminRights(
                  teamId!, user.id, callerUserId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        "Droit d'administration donné à ${user.userName}")),
              );
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Échec lors de la requête pour donner les droits d'administration: $error"),
                ),
              );
            }
            Navigator.pop(context); // Ferme le dialogue après l'action
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = false;
    if (team.admins!.any((admin) => admin.id == user.id)) {
      isAdmin = true;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: (isPending ? Colors.grey[300] : Colors.grey[100]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isPending)
                    const Text(
                      "(Requête de participation)",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  Row(
                    children: [
                      Text(
                        '${user.userName} ',
                        style: TextStyle(
                          color: isPending
                              ? Colors.black.withOpacity(0.6)
                              : Colors.black,
                        ),
                      ),
                      if (isAdmin)
                        const Text(
                          '(Admin)',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: TextStyle(
                      color: isPending
                          ? Colors.black.withOpacity(0.6)
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (isPending) // Display icons only if user is pending
              Row(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(maxHeight: 24),
                    padding: EdgeInsets.zero,
                    iconSize: 24,
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: onAccept, // Call onAccept callback
                  ),
                  IconButton(
                    constraints: const BoxConstraints(maxHeight: 24),
                    padding: EdgeInsets.zero,
                    iconSize: 24,
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: onReject, // Call onReject callback
                  )
                ],
              )
            else // Display edit button if user is not pending

              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  if (!isAdmin)
                    const PopupMenuItem<String>(
                      value: 'grantAdmin',
                      child: Row(
                        children: [
                          Icon(Icons.admin_panel_settings, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Donner les droits d\'admin'),
                        ],
                      ),
                    ),
                  const PopupMenuItem<String>(
                    value: 'eject',
                    child: Row(
                      children: [
                        Icon(Icons.person_remove, color: Colors.black),
                        SizedBox(width: 8),
                        Text('Éjecter l\'utilisateur'),
                      ],
                    ),
                  ),
                ],
                onSelected: (String value) {
                  _onActionSelected(value, context);
                },
              ),
          ],
        ),
      ),
    );
  }
}
