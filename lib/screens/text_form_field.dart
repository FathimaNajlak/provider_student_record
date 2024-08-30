// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ReuseTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final int? maxLength;
  final String validationMessage;

  ReuseTextFormField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    this.maxLength,
    required this.validationMessage,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validationMessage;
        } else if (maxLength != null && value.length != 10) {
          return 'Mobile number should be 10 digits';
        }
        return null;
      },
    );
  }
}
