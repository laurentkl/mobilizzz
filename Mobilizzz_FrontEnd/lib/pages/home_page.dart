import 'package:flutter/material.dart';
import 'package:mobilizzz/pages/add_record_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/widgets/profile_banner.dart'; // Assuming profile_banner.dart has ProfileBanner
import 'package:mobilizzz/widgets/records_list.dart';
import 'package:provider/provider.dart'; // Assuming records_list.dart has RecordsList

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, RecordProvider>(
      builder: (context, authProvider, recordProvider, child) {
        final user = authProvider.user;
        final userRecords = recordProvider.records
            .where((record) => record.userId == user?.id)
            .toList();


        return Scaffold(
          body: Stack( // Use Stack for positioning
            children: [
              Column(
                children: [
                  const ProfileBanner(),
                  Expanded(child: RecordsList(records: userRecords)),
                ],
              ),
              Positioned( // Position button at bottom right
                bottom: 20.0, // Adjust for spacing from bottom
                right: 20.0,  // Adjust for spacing from right
                child: FloatingActionButton(
                  heroTag: "home-btn-insert",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const AddRecordPage()));
                  }, 
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add), 
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
