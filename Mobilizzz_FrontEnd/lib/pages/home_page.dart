import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/pages/add_record_page.dart';
import 'package:mobilizzz/pages/edit_profile_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/widgets/home_page/home_records_filters.dart';
import 'package:mobilizzz/widgets/home_page/home_header.dart';
import 'package:mobilizzz/widgets/home_page/profile_banner.dart';
import 'package:mobilizzz/widgets/home_page/records_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<RecordProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    recordProvider.getRecordsById(authProvider.user!.id);

    return Consumer2<AuthProvider, RecordProvider>(
      builder: (context, authProvider, recordProvider, child) {
        final filteredUserRecords = recordProvider.filteredUserRecords;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstants.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.person_2),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );
              },
            ),
            actions: [
              //deconetion
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  authProvider.signOut();
                },
              ),
            ],
          ),
          body: Container(
            color: AppConstants.backgroundColor,
            child: SafeArea(
              child: Column(
                children: [
                  HomeStats(userRecords: filteredUserRecords),
                  RecordsFilters(
                    onTransportMethodFilterSelected: (transportMethod) {
                      recordProvider.filterByTransportMethod(transportMethod);
                    },
                    onTypeFilterSelected: (type) {
                      recordProvider.filterByType(type);
                    },
                  ),
                  Expanded(
                    child: RecordsList(userRecords: filteredUserRecords),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
