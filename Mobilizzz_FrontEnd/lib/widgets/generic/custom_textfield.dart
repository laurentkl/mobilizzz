import 'package:flutter/material.dart';
import 'package:mobilizzz/constants/constants.dart';

/// A customizable text input field widget that optionally wraps itself in a Flexible widget.
///
/// This widget is designed to provide enhanced flexibility and customization options
/// for text input fields within Flutter applications.
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final bool isFlexible;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.isFlexible = true,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textField = TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator, // Utilize the provided validator function
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
            color: AppConstants.primaryColor,
            width: 2.0,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      ),
    );

    // Wrap the TextFormField in a Flexible widget if isFlexible is true, otherwise return it directly
    if (isFlexible) {
      return Flexible(
        child: textField,
      );
    } else {
      return textField;
    }
  }
}
