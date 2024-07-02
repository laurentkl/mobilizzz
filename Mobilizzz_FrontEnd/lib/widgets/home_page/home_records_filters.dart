import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';

class RecordsFilters extends StatefulWidget {
  final Function(String) onTransportMethodFilterSelected;
  final Function(String) onTypeFilterSelected;

  const RecordsFilters(
      {Key? key,
      required this.onTransportMethodFilterSelected,
      required this.onTypeFilterSelected})
      : super(key: key);

  @override
  _RecordsFiltersState createState() => _RecordsFiltersState();
}

class _RecordsFiltersState extends State<RecordsFilters> {
  String _selectedTransportMethodForFilter = '';
  String _selectedTypeForFilter = '';

  void _handleTransportMethodFilterSelection(String transportMethod) {
    setState(() {
      if (_selectedTransportMethodForFilter == transportMethod) {
        _selectedTransportMethodForFilter =
            ''; // Deselect the filter if it's already selected
      } else {
        _selectedTransportMethodForFilter = transportMethod;
      }
    });
    widget.onTransportMethodFilterSelected(_selectedTransportMethodForFilter);
  }

  void _handleTypeFilterSelection(String type) {
    setState(() {
      if (_selectedTypeForFilter == type) {
        _selectedTypeForFilter =
            ''; // Deselect the filter if it's already selected
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
                color: _selectedTransportMethodForFilter == 'bus'
                    ? AppConstants.primaryColor
                    : AppConstants.inactiveColor,
              ),
              onPressed: () => _handleTransportMethodFilterSelection('bus'),
            ),
            IconButton(
              icon: Icon(
                Icons.directions_bike,
                color: _selectedTransportMethodForFilter == 'bike'
                    ? AppConstants.primaryColor
                    : AppConstants.inactiveColor,
              ),
              onPressed: () => _handleTransportMethodFilterSelection('bike'),
            ),
            IconButton(
              icon: Icon(
                Icons.directions_walk,
                color: _selectedTransportMethodForFilter == 'walk'
                    ? AppConstants.primaryColor
                    : AppConstants.inactiveColor,
              ),
              onPressed: () => _handleTransportMethodFilterSelection('walk'),
            ),
            IconButton(
              icon: Icon(
                Icons.directions_car,
                color: _selectedTransportMethodForFilter == 'car'
                    ? AppConstants.primaryColor
                    : AppConstants.inactiveColor,
              ),
              onPressed: () => _handleTransportMethodFilterSelection('car'),
            ),
          ],
        ),
        const Spacer(), // Spacer to push the type icons to the right
        // Types
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.track_changes_outlined,
                  color: _selectedTypeForFilter == 'mission'
                      ? AppConstants.primaryColor
                      : AppConstants.inactiveColor),
              onPressed: () => _handleTypeFilterSelection('mission'),
            ),
            IconButton(
              icon: Icon(Icons.favorite,
                  color: _selectedTypeForFilter == 'personal'
                      ? AppConstants.primaryColor
                      : AppConstants.inactiveColor),
              onPressed: () => _handleTypeFilterSelection('personal'),
            ),
            IconButton(
              icon: Icon(Icons.alarm,
                  color: _selectedTypeForFilter == 'work'
                      ? AppConstants.primaryColor
                      : AppConstants.inactiveColor),
              onPressed: () => _handleTypeFilterSelection('work'),
            ),
          ],
        ),
      ],
    );
  }
}