import 'package:flutter/material.dart';
import 'package:t89/config/styles/app_colors.dart';

class KTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  const KTextfield({
    super.key,
    this.controller,
    this.label,
    this.validator,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              bottom: 4,
            ),
            child: Text(
              label!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
              ),
            ),
          ),
        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: textInputType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.borderColor5,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
        ),
      ],
    );
  }
}
