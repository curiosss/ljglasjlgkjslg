import 'package:flutter/material.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/config/styles/textstyles.dart';

class KElevatedButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const KElevatedButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkblue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        title,
        style: AppTextStyles.f15w500,
      ),
    );
  }
}
