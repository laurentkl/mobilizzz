import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/dialogs/transport_ranking_dialog.dart';
import 'package:mobilizzz/enums/enums.dart';
import 'package:mobilizzz/models/record_model.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:mobilizzz/widgets/generic/stat_box.dart';
import 'package:provider/provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordProvider>(
      builder: (context, recordProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => TransportRankingDialog(
                        records: recordProvider.userRecords,
                      ),
                    );
                  },
                  child: StatBox(
                    icon: Icon(
                      getTransportMethodIcon(
                          recordProvider.mostUsedTransportMethod["name"] ??
                              TransportMethod.bike),
                      color: AppConstants.primaryColor,
                      size: 34.0,
                    ),
                    title: "Préféré",
                    value:
                        "${recordProvider.mostUsedTransportMethod["distance"].toStringAsFixed(0)} km",
                  ),
                ),
              ),
              StatBox(
                icon: const Icon(
                  Icons.add_road,
                  color: AppConstants.primaryColor,
                  size: 34.0,
                ),
                title: "Total",
                value: "${recordProvider.totalKm.toStringAsFixed(0)} km",
              ),
              StatBox(
                icon: const Icon(
                  Icons.calendar_today,
                  color: AppConstants.primaryColor,
                  size: 34.0,
                ),
                title: "Consécutif",
                value:
                    "${recordProvider.consecutiveRecords} jours", // Replace with dynamic value
              ),
            ],
          ),
        );
      },
    );
  }
}
