import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String label;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.label,
    this.maxLines,
    this.keyboardType,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          maxLines: maxLines ?? 1,
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: TextStyle(
              color: context.watch<ThemeProvider>().getThemeValue()
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.black.withValues(alpha: 0.5),
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: context.watch<ThemeProvider>().getThemeValue()
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.black.withValues(alpha: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 1),
              borderRadius: BorderRadius.circular(11),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.watch<ThemeProvider>().getThemeValue()
                    ? Colors.white
                    : Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade400, width: 1),
              borderRadius: BorderRadius.circular(11),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ),
      ],
    );
  }
}
