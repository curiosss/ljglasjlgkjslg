import 'package:go_router/go_router.dart';
import 'package:t89/core/router/app_routes.dart';
import 'package:t89/core/widget_keys/widget_keys.dart';
import 'package:t89/features/achievements/presentation/pages/achievements_page.dart';
import 'package:t89/features/home/presentation/pages/home_page.dart';
import 'package:t89/features/onboarding/onboarding_page.dart';
import 'package:t89/features/products/presentation/pages/products_page.dart';
import 'package:t89/features/settings/presentation/pages/settings_page.dart';
import 'package:t89/features/statistics/presentation/pages/statistics_page.dart';
import 'package:t89/splash_screen.dart';
import 'scaffold_with_nested_nav.dart';

final goRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  navigatorKey: rootNavKey,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: shellNavKeyHome,
          routes: [
            GoRoute(
              path: AppRoutes.home,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: HomePage(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavKeyProducts,
          routes: [
            GoRoute(
              path: AppRoutes.products,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: ProductsPage(),
                );
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavKeyStatistics,
          routes: [
            GoRoute(
              path: AppRoutes.statistics,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: StatisticsPage(),
                );
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavKeyAchievements,
          routes: [
            GoRoute(
              path: AppRoutes.achievements,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: AchievementsPage(),
                );
              },
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shellNavKeySettings,
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: SettingsPage(),
                );
              },
            )
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) {
        return const OnBoardingPage();
      },
    ),
  ],
);
