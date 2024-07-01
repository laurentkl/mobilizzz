import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/pages/add_record_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/widgets/home_filters.dart';
import 'package:mobilizzz/widgets/home_header.dart';
import 'package:mobilizzz/widgets/profile_banner.dart';
import 'package:mobilizzz/widgets/records_list.dart';
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
        final user = authProvider.user;
        final userRecords = recordProvider.userRecords;
        final filteredUserRecords = recordProvider.filteredUserRecords;

        return Scaffold(
          body: Container(
            color: AppConstants.primaryColor,
            child: SafeArea(
              child: Column(
                children: [
                  HomeHeader(userRecords: filteredUserRecords),
                  TransportFilter(onFilterSelected: (transportMethod) {
                    recordProvider.filterByTransportType(transportMethod);
                  }),
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
