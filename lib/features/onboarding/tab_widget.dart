import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t89/config/styles/textstyles.dart';

class TabWidget extends StatelessWidget {
  final String label;
  final String imagePath;
  const TabWidget({
    super.key,
    required this.label,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 39,
            vertical: 35,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.f16w400,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 52,
              right: 52,
              bottom: 10,
            ),
            child: SvgPicture.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
