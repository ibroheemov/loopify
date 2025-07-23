import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLength;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLength = 50,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.colorScheme.surface,
            hintText: hintText ?? 'Enter $label',
            enabledBorder: _border(theme),
            focusedBorder: _border(theme),
            focusedErrorBorder: _errorBorder(theme),
            errorBorder: _errorBorder(theme),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  static _border(ThemeData theme) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: theme.colorScheme.outline),
      borderRadius: BorderRadius.circular(18),
    );
  }

  static _errorBorder(ThemeData theme) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: theme.colorScheme.error),
      borderRadius: BorderRadius.circular(18),
    );
  }
}
