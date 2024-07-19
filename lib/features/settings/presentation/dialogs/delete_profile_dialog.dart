import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/core/router/app_routes.dart';
import 'package:t89/core/widget_keys/widget_keys.dart';
import 'package:t89/features/settings/controllers/settings_controller.dart';
import 'package:t89/injection_container.dart';

showDeleteProfileDialog() {
  showDialog(
    context: rootNavKey.currentContext!,
    builder: (context) => const DeleteProfileDialog(),
  ).then((value) {
    if (value != null && value) {
      rootNavKey.currentContext!.go(AppRoutes.onboarding);
    }
  });
}

class DeleteProfileDialog extends StatelessWidget {
  const DeleteProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 15,
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure want to delete profile?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.darkblue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: Text(
                'This will completely and irrevocably delete your profile.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkblue.withOpacity(0.5),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                          right: Radius.circular(4),
                        )),
                        side: const BorderSide(
                          width: 1,
                          color: AppColors.darkblue,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkblue,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 1),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        getIt<SettingsController>().deleteProfile();
                        context.go(AppRoutes.onboarding);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(4),
                          right: Radius.circular(30),
                        )),
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
