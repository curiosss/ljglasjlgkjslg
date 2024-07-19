import 'package:flutter/material.dart';
import 'package:t89/common/widgets/k_appbar.dart';
import 'package:t89/features/settings/presentation/dialogs/delete_profile_dialog.dart';
import 'package:t89/features/settings/presentation/dialogs/send_feedback_dialog.dart';
import 'package:t89/features/settings/presentation/widgets/company_info_widget.dart';
import 'package:t89/features/settings/presentation/widgets/k_listtile_widget.dart';
import 'package:t89/features/settings/presentation/widgets/notification_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(
        iconPath: 'assets/navbar_icons/settings.svg',
        title: 'SETTINGS',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 50,
          left: 15,
          right: 15,
          bottom: 15,
        ),
        child: Column(
          children: [
            const CompanyInfoWidget(),
            const SizedBox(height: 25),
            const KListTileWidget(
              iconPath: 'assets/icons/notification.svg',
              title: 'Notifications',
              trailing: NotificationSwitch(),
            ),
            const SizedBox(height: 15),
            const KListTileWidget(
              iconPath: 'assets/icons/like-shapes.svg',
              title: 'Rate Us',
            ),
            const SizedBox(height: 15),
            KListTileWidget(
              iconPath: 'assets/icons/like-shapes.svg',
              title: 'Feedback',
              onTap: () {
                showSendFeedbackDialog();
              },
            ),
            const SizedBox(height: 15),
            KListTileWidget(
              iconPath: 'assets/icons/trash.svg',
              title: 'Delete Profile',
              isRedColored: true,
              onTap: () {
                showDeleteProfileDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}
