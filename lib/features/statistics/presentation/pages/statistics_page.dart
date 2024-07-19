import 'package:flutter/material.dart';
import 'package:t89/common/widgets/k_appbar.dart';
import 'package:t89/features/statistics/presentation/widgets/k_bar_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: KAppBar(
        iconPath: 'assets/navbar_icons/chart.svg',
        title: 'STATISTICS',
      ),
      body: Column(
        children: [
          SizedBox(height: 25),
          KBarChart(),
        ],
      ),
    );
  }
}
