import 'package:flutter/cupertino.dart';
import 'package:t89/features/settings/controllers/settings_controller.dart';
import 'package:t89/injection_container.dart';

class NotificationSwitch extends StatelessWidget {
  const NotificationSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = getIt<SettingsController>();
    return ListenableBuilder(
        listenable: settingsController,
        builder: (context, _) {
          return CupertinoSwitch(
            value: settingsController.isNotificationsOn,
            onChanged: (val) {
              settingsController.toggleNotification();
            },
          );
        });
  }
}
