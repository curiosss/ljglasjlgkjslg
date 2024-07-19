import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t89/config/styles/app_colors.dart';

class KListTileWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final Widget? trailing;
  final bool isRedColored;
  final Function()? onTap;
  const KListTileWidget({
    super.key,
    required this.iconPath,
    required this.title,
    this.trailing,
    this.isRedColored = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isRedColored ? const Color(0xffFFE7E7) : AppColors.lightGrey,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color:
                            isRedColored ? AppColors.red : AppColors.darkblue,
                      ),
                    ),
                  ),
                ),
                trailing ??
                    SvgPicture.asset(
                      'assets/icons/arrow_right.svg',
                      colorFilter: ColorFilter.mode(
                        isRedColored ? AppColors.red : AppColors.darkblue,
                        BlendMode.srcIn,
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
