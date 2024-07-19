import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/core/router/app_routes.dart';
import 'package:t89/features/settings/controllers/settings_controller.dart';
import 'package:t89/injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Duration duration = const Duration(milliseconds: 500);
  Timer? timer;
  String dotSuffix = '.';
  int passedTimeMs = 0;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  init() async {
    startAnimation();
    await setupLocator();
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      if (getIt<SettingsController>().showOnboarding) {
        context.go(AppRoutes.onboarding);
      } else {
        context.go(AppRoutes.home);
      }
    }
  }

  startAnimation() {
    timer = Timer.periodic(duration, tick);
  }

  tick(Timer t) {
    dotSuffix += '.';
    if (dotSuffix.length > 3) {
      dotSuffix = '.';
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 49),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 150),
              child: Text(
                'Loading$dotSuffix',
                style: const TextStyle(
                  color: AppColors.orange,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
