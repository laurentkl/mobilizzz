import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';
import 'package:mobilizzz/enums/enums.dart';

class RecordsFilters extends StatefulWidget {
  final Function(
    TransportMethod?,
  ) onTransportMethodFilterSelected;
  final Function(RecordType?) onTypeFilterSelected;

  const RecordsFilters(
      {Key? key,
      required this.onTransportMethodFilterSelected,
      required this.onTypeFilterSelected})
      : super(key: key);

  @override
  _RecordsFiltersState createState() => _RecordsFiltersState();
}

class _RecordsFiltersState extends State<RecordsFilters> {
  TransportMethod? _selectedTransportMethodForFilter;
  RecordType? _selectedTypeForFilter;

  void _handleTransportMethodFilterSelection(TransportMethod transportMethod) {
    setState(() {
      if (_selectedTransportMethodForFilter == transportMethod) {
        _selectedTransportMethodForFilter = null;
      } else {
        _selectedTransportMethodForFilter = transportMethod;
      }
    });
    widget.onTransportMethodFilterSelected(_selectedTransportMethodForFilter);
  }

  void _handleTypeFilterSelection(RecordType type) {
    setState(() {
      if (_selectedTypeForFilter == type) {
        _selectedTypeForFilter =
            null; // Deselect the filter if it's already selected
      } else {
        _selectedTypeForFilter = type;
      }
    });
    widget.onTypeFilterSelected(_selectedTypeForFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Transport methods
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.directions_bus,
                color: _selectedTransportMethodForFilter == TransportMethod.bus
                    ? AppConstants.primaryColor
                    : AppConstants.inactiveColor,
              ),
              onPressed: () =>
                  _handleTransportMethodFilterSelection(TransportMethod.bus),
            ),
            IconButton(
              icon: Icon(
                Icons.directions_bike,
                color: _selectedTransportMethodForFilter == TransportMethod.bike
                    ? AppConstants.primaryColor
                    : AppConstants.inactiveColor,
              ),
              onPressed: () =>
                  _handleTransportMethodFilterSelection(TransportMethod.bike),
            ),
            IconButton(
              icon: Icon(
                Icons.directions_walk,
                color: _selectedTransportMethodForFilter == TransportMethod.walk
                    ? AppConstants.primaryColor
                    : AppConstants.inactiveColor,
              ),
              onPressed: () =>
                  _handleTransportMethodFilterSelection(TransportMethod.walk),
            ),
            IconButton(
              icon: Icon(
                Icons.directions_car,
                color: _selectedTransportMethodForFilter ==
                        TransportMethod.carpooling
                    ? AppConstants.primaryColor
                    : AppConstants.inactiveColor,
              ),
              onPressed: () => _handleTransportMethodFilterSelection(
                  TransportMethod.carpooling),
            ),
          ],
        ),
        const Spacer(),
        // Types
        Row(
          children: [
            IconButton(
              icon: Icon(AppConstants.recordTypeWorkIcon,
                  color: _selectedTypeForFilter == RecordType.work
                      ? AppConstants.primaryColor
                      : AppConstants.inactiveColor),
              onPressed: () => _handleTypeFilterSelection(RecordType.work),
            ),
            IconButton(
              icon: Icon(AppConstants.recordTypeMissionIcon,
                  color: _selectedTypeForFilter == RecordType.mission
                      ? AppConstants.primaryColor
                      : AppConstants.inactiveColor),
              onPressed: () => _handleTypeFilterSelection(RecordType.mission),
            ),
            IconButton(
              icon: Icon(AppConstants.recordTypePrivateIcon,
                  color: _selectedTypeForFilter == RecordType.private
                      ? AppConstants.primaryColor
                      : AppConstants.inactiveColor),
              onPressed: () => _handleTypeFilterSelection(RecordType.private),
            ),
          ],
        ),
      ],
    );
  }
}
