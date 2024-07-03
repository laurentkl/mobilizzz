import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/models/user_model.dart';

class ManagedUserRow extends StatelessWidget {
  const ManagedUserRow({
    Key? key,
    required this.user,
    required this.isPending,
  }) : super(key: key);

  final User user;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isPending ? Colors.lightBlue : AppConstants.primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              child: Text(
                user.email ?? '',
                style: TextStyle(
                  color: isPending ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
