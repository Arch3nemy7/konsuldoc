import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final Color fillColor;
  final TextStyle hintStyle;
  final BorderSide borderSide;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.fillColor,
    required this.hintStyle,
    required this.borderSide,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(icon),
        hintText: hintText,
        hintStyle: hintStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: borderSide,
        ),
      ),
    );
  }
}
