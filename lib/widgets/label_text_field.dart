import 'package:flutter/material.dart';
import 'package:promilo/utils/colors.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    super.key,
    this.controller,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    required this.hintText,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Text(
            label,
            style: theme.textTheme.titleMedium
                ?.copyWith(color: AppColors.labelTextField),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
