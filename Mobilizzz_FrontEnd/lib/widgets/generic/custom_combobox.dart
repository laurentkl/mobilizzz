import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart'; // Assurez-vous d'importer vos constantes correctement

class CustomComboBox<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const CustomComboBox({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[700],
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppConstants
                .primaryColor, // Assurez-vous que cette constante est définie correctement dans vos constantes
            width: 2.0,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
