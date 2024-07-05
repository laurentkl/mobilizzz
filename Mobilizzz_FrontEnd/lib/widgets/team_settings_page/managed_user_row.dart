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
              IconButton(
                constraints: const BoxConstraints(maxHeight: 24),
                padding: EdgeInsets.zero,
                iconSize: 24,
                icon: const Icon(Icons.edit, color: AppConstants.primaryColor),
                onPressed: (() => {}), // Call onEdit callback
              ),
          ],
        ),
      ),
    );
  }
}
