import 'package:flutter/material.dart';

class GothicTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool isValid;
  final bool isPassword;
  final VoidCallback? onToggleVisibility;

  const GothicTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.errorText,
    this.onChanged,
    this.isValid = false,
    this.isPassword = false,
    this.onToggleVisibility,
  });

  @override
  State<GothicTextField> createState() => _GothicTextFieldState();
}

class _GothicTextFieldState extends State<GothicTextField> {
  bool _showPassword = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    final showValid =
        widget.isValid && !hasError && widget.controller.text.isNotEmpty;
    final isPasswordField = widget.isPassword && widget.obscureText;

    // Lógica de color mejorada
    Color borderColor = const Color(0xFFD6C8B0); // Color normal

    if (_isFocused) {
      borderColor =
          showValid
              ? const Color(0xFFB7D6B8) // Verde cuando es válido y enfocado
              : hasError
              ? const Color(0xFFCE8381) // Rojo cuando hay error y enfocado
              : const Color(
                0xFFE0D3B8,
              ); // Amarillo suave cuando enfocado pero no validado
    } else if (showValid) {
      borderColor = const Color(
        0xFFB7D6B8,
      ); // Verde cuando es válido pero no enfocado
    } else if (hasError) {
      borderColor = const Color(0xFFCE8381); // Rojo cuando hay error
    }

    return FocusScope(
      onFocusChange: (hasFocus) {
        setState(() => _isFocused = hasFocus);
      },
      child: TextField(
        controller: widget.controller,
        obscureText: isPasswordField && !_showPassword,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: borderColor, fontSize: 20),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 4),
          ),
          errorText: widget.errorText,
          errorStyle: const TextStyle(color: Color(0xFFCE8381), fontSize: 16),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFCE8381), width: 4),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFCE8381), width: 4),
          ),
          suffixIcon: _buildSuffixIcon(isPasswordField),
        ),
        style: TextStyle(color: borderColor),
      ),
    );
  }

  Widget? _buildSuffixIcon(bool isPasswordField) {
    if (isPasswordField) {
      return IconButton(
        icon: Icon(
          _showPassword ? Icons.visibility : Icons.visibility_off,
          color: const Color(0xFFD6C8B0),
        ),
        onPressed: () {
          setState(() => _showPassword = !_showPassword);
          widget.onToggleVisibility?.call();
        },
      );
    }

    if (widget.isValid && widget.controller.text.isNotEmpty) {
      return const Icon(Icons.check_circle, color: Color(0xFFB7D6B8));
    }

    return null;
  }
}
