import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/features/settings/controllers/settings_controller.dart';
import 'package:t89/features/settings/presentation/dialogs/add_companyinfo_dialog.dart';
import 'package:t89/injection_container.dart';

class CompanyInfoWidget extends StatelessWidget {
  const CompanyInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = getIt<SettingsController>();
    return ListenableBuilder(
      listenable: settingsController,
      builder: (context, _) {
        return Row(
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child:
                  settingsController.companyInfo?.imagePath.isNotEmpty ?? false
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(settingsController.companyInfo!.imagePath),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.lightGrey,
                          ),
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            'assets/icons/camera.svg',
                          ),
                        ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 47),
                  decoration: const BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(6),
                      right: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    left: 15,
                    // top: 15,
                    // bottom: 15,
                    right: 10,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            settingsController.companyInfo?.name ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            showCompanyInfoDialog(
                              companyInfo: settingsController.companyInfo,
                            );
                          },
                          padding: const EdgeInsets.all(5),
                          constraints:
                              const BoxConstraints(maxHeight: 54, maxWidth: 54),
                          splashRadius: 18,
                          icon: SvgPicture.asset(
                            'assets/icons/edit.svg',
                            colorFilter: const ColorFilter.mode(
                              AppColors.darkblue20,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
