import 'package:flutter/material.dart';

class GothicTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;
  final bool? isValid;
  final ValueChanged<String>? onChanged;

  const GothicTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.errorText,
    this.onChanged,
    this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;

    final borderColor =
        hasError
            ? const Color(0xFFCE8381)
            : isValid == true
            ? Colors.green
            : const Color(0xFFD6C8B0);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12, // Reducido de 14
          horizontal: 14, // Reducido de 16
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: borderColor,
          fontSize: 14,
        ), // Reducido de 16
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ), // Bordes redondeados
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
          borderSide: BorderSide(color: borderColor, width: 4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
          borderSide: BorderSide(color: borderColor, width: 4),
        ),
        errorText: errorText,
        errorStyle: const TextStyle(color: Color(0xFFCE8381), fontSize: 12),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ), // Bordes redondeados
          borderSide: BorderSide(color: Color(0xFFCE8381), width: 4),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ), // Bordes redondeados
          borderSide: BorderSide(color: Color(0xFFCE8381), width: 4),
        ),
      ),
      style: TextStyle(
        color: borderColor,
        fontSize: 15,
      ), // Tamaño de texto interno
    );
  }
}
