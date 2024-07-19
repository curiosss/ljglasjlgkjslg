import 'package:t89/features/achievements/models/achievement_item_model.dart';
import 'package:t89/features/achievements/models/achievement_model.dart';

enum AchievementPosition {
  rookie,
  advanced,
  expert,
  master,
  guru,
}

abstract final class AchievementsData {
  static final List<AchievementModel> achievements = [
    AchievementModel(
      position: AchievementPosition.rookie,
      isAchieved: false,
      name: 'Rookie:',
      items: [
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Sell your first item',
          status: '(0/1)',
        ),
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Earn your first dollar',
          status: '(0/1)',
        ),
      ],
    ),
    AchievementModel(
      position: AchievementPosition.advanced,
      isAchieved: false,
      name: 'Advanced Seller:',
      items: [
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Sell 50 items',
          status: '(0/50)',
        ),
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Earn \$1000',
          status: '(0/1000)',
        ),
      ],
    ),
    AchievementModel(
      position: AchievementPosition.expert,
      isAchieved: false,
      name: 'Expert',
      items: [
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Sell 100 items',
          status: '(0/100)',
        ),
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Receive positive feedback from 90% of customers',
          status: '',
        ),
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Invite 10 new sellers to the platform ',
          status: '(0/10)',
        ),
      ],
    ),
    AchievementModel(
      position: AchievementPosition.master,
      isAchieved: false,
      name: 'Master Reseller',
      items: [
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Sell 500 items',
          status: '(0/500)',
        ),
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Earn the title of "Top Seller of the Month"',
          status: '',
        ),
      ],
    ),
    AchievementModel(
      position: AchievementPosition.guru,
      isAchieved: false,
      name: 'Market Guru',
      items: [
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Sell 1000 items',
          status: '(0/1000)',
        ),
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Receive an award for the highest average customer rating',
          status: '',
        ),
        AchievementItemModel(
          isAchieved: false,
          name: '∙ Help 50 newcomers in the community',
          status: '(0/50)',
        ),
      ],
    ),
  ];
}
