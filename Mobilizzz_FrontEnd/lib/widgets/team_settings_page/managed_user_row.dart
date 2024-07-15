import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/user_model.dart';

class ManagedUserRow extends StatelessWidget {
  const ManagedUserRow({
    Key? key,
    required this.user,
    required this.isPending,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  final User user;
  final bool isPending;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  void _onActionSelected(User user, String action) {
    switch (action) {
      case 'eject':
        _ejectUser(user);
        break;
      case 'grantAdmin':
        _grantAdminRights(user);
        break;
      default:
        break;
    }
  }

  void _ejectUser(User user) {
    // Implémentez la logique pour éjecter l'utilisateur de l'équipe
    // Vous pouvez utiliser Provider pour appeler la méthode appropriée dans TeamProvider
  }

  void _grantAdminRights(User user) {
    // Implémentez la logique pour donner les droits d'administrateur à l'utilisateur
    // Vous pouvez utiliser Provider pour appeler la méthode appropriée dans TeamProvider
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isPending ? Colors.grey[300] : Colors.grey[100],
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
                    Text(
                      "(Requête de participation)",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  Text(
                    '${user.userName} (${user.email})',
                    style: TextStyle(
                      color: isPending
                          ? Colors.black.withOpacity(0.6)
                          : Colors.black,
                    ),
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
                  const PopupMenuItem<String>(
                    value: 'grantAdmin',
                    child: Text('Donner les droits d\'admin'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'eject',
                    child: Text('Éjecter l\'utilisateur'),
                  ),
                ],
                onSelected: (String value) {
                  _onActionSelected(user, value);
                },
              ),
          ],
        ),
      ),
    );
  }
}
