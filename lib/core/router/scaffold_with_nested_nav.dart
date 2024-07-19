import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/core/widget_keys/widget_keys.dart';

class ScaffoldWithNestedNavigation extends StatefulWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNestedNavigation> createState() =>
      _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState
    extends State<ScaffoldWithNestedNavigation> {
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    items = [
      BottomNavigationBarItem(
        label: 'Main',
        icon: buildIcon('assets/navbar_icons/home.svg'),
        activeIcon: buildActiveIcon('assets/navbar_icons/home.svg'),
      ),
      BottomNavigationBarItem(
        label: 'Products',
        icon: buildIcon('assets/navbar_icons/bag.svg'),
        activeIcon: buildActiveIcon('assets/navbar_icons/bag.svg'),
      ),
      BottomNavigationBarItem(
        label: 'Statistics',
        icon: buildIcon('assets/navbar_icons/chart.svg'),
        activeIcon: buildActiveIcon('assets/navbar_icons/chart.svg'),
      ),
      BottomNavigationBarItem(
        label: 'Achievements',
        icon: buildIcon('assets/navbar_icons/ranking.svg'),
        activeIcon: buildActiveIcon('assets/navbar_icons/ranking.svg'),
      ),
      BottomNavigationBarItem(
        label: 'Settings',
        icon: buildIcon('assets/navbar_icons/settings.svg'),
        activeIcon: buildActiveIcon('assets/navbar_icons/settings.svg'),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        key: bottomNavBarKey,
        onTap: _goBranch,
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: widget.navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.darkblue,
        selectedLabelStyle: const TextStyle(
          fontSize: 11.3,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11.3,
          fontWeight: FontWeight.w500,
        ),
        items: items,
      ),
    );
  }

  Widget buildIcon(String iconPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SvgPicture.asset(iconPath),
    );
  }

  Widget buildActiveIcon(String iconPath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.orange30,
      ),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: const ColorFilter.mode(
          AppColors.orange,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
