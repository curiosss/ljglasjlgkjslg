import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/features/achievements/models/achievement_model.dart';

class AchievementItemWidget extends StatelessWidget {
  final AchievementModel achievement;
  const AchievementItemWidget({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.lightGrey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            achievement.isAchieved
                ? 'assets/icons/star_filled.svg'
                : 'assets/icons/star.svg',
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkblue,
                  ),
                ),
                const SizedBox(height: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: achievement.items.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Text(
                        '${e.name} ${e.isAchieved ? '(Achieved)' : e.status}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkblue,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
