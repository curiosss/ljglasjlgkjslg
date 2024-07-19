import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/config/styles/textstyles.dart';
import 'package:t89/core/router/app_routes.dart';
import 'package:t89/features/onboarding/tab_widget.dart';
import 'package:t89/features/settings/controllers/settings_controller.dart';
import 'package:t89/injection_container.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    tabController.addListener(onTabChange);
    super.initState();
  }

  @override
  dispose() {
    tabController.dispose();
    super.dispose();
  }

  onTabChange() {
    setState(() {});
  }

  onTapContinue() {
    if (tabController.index < 2) {
      tabController.animateTo(tabController.index + 1);
    } else {
      getIt<SettingsController>().viewOnboarding();
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                    ),
                    height: 70,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        const Text(
                          'Welcome',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.f28w600,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Watch ',
                            style: AppTextStyles.f28w600,
                            children: [
                              TextSpan(
                                text: 'Statistics',
                                style: AppTextStyles.f28w600.copyWith(
                                  color: AppColors.orange,
                                ),
                              )
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Collect ',
                            style: AppTextStyles.f28w600,
                            children: [
                              TextSpan(
                                text: 'Achievements',
                                style: AppTextStyles.f28w600.copyWith(
                                  color: AppColors.orange,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 37.5),
                    child: TabBar(
                      controller: tabController,
                      indicator: null,
                      indicatorWeight: 0.1,
                      indicatorColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Container(
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Container(
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          decoration: BoxDecoration(
                            color: tabController.index > 0
                                ? AppColors.orange
                                : AppColors.grey,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Container(
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          decoration: BoxDecoration(
                            color: tabController.index > 1
                                ? AppColors.orange
                                : AppColors.grey,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        TabWidget(
                          label:
                              'App Name is your virtual store simulator. Create your company and develop it!',
                          imagePath: 'assets/images/boarding_bg1.svg',
                        ),
                        TabWidget(
                          label:
                              'Track your product data in real time, sort or view data on all products',
                          imagePath: 'assets/images/boarding_bg2.svg',
                        ),
                        TabWidget(
                          label: 'Collect achievements for completed tasks ',
                          imagePath: 'assets/images/boarding_bg3.svg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 60,
              left: 15,
              right: 15,
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkblue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: onTapContinue,
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
