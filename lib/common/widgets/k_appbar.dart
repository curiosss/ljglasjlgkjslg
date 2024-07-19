import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t89/config/styles/app_colors.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String iconPath;
  final String title;
  const KAppBar({
    super.key,
    required this.iconPath,
    required this.title,
  });

  @override
  Size get preferredSize => const Size(
        double.infinity,
        kToolbarHeight,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      title: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: const ColorFilter.mode(
              AppColors.orange,
              BlendMode.srcIn,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
