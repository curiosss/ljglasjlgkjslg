import 'package:flutter/material.dart';
import 'package:t89/common/widgets/k_appbar.dart';
import 'package:t89/features/achievements/presentation/widgets/achievement_item_widget.dart';
import 'package:t89/features/shop/controller/shop_controller.dart';
import 'package:t89/injection_container.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ShopController shopController = getIt<ShopController>();
    return Scaffold(
      appBar: const KAppBar(
        iconPath: 'assets/navbar_icons/ranking.svg',
        title: 'ACHIEVEMENTS',
      ),
      body: ListenableBuilder(
        listenable: shopController,
        builder: (context, _) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17.5),
            itemCount: shopController.achievements.length,
            itemBuilder: (context, index) {
              return AchievementItemWidget(
                achievement: shopController.achievements[index],
              );
            },
          );
        },
      ),
    );
  }
}
