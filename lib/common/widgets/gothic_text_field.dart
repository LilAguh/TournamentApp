import 'package:flutter/material.dart';

class GothicTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const GothicTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: hasError ? const Color(0xFFCE8381) : const Color(0xFFD6C8B0),
          fontSize: 20,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: hasError ? const Color(0xFFCE8381) : const Color(0xFFD6C8B0),
            width: 4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: hasError ? const Color(0xFFCE8381) : const Color(0xFFD6C8B0),
            width: 4,
          ),
        ),
        errorText: errorText,
        errorStyle: const TextStyle(color: Color(0xFFCE8381), fontSize: 16),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFCE8381), width: 4),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFCE8381), width: 4),
        ),
      ),
      style: TextStyle(
        color: hasError ? const Color(0xFFCE8381) : const Color(0xFFD6C8B0),
      ),
    );
  }
}
