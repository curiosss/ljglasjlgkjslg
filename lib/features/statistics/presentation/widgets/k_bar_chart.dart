import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/features/shop/controller/shop_controller.dart';
import 'package:t89/features/shop/models/day_sales_model.dart';
import 'package:t89/injection_container.dart';

class KBarChart extends StatelessWidget {
  const KBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    ShopController shopController = getIt<ShopController>();
    return ListenableBuilder(
      listenable: shopController,
      builder: (context, _) {
        List<DaySalesModel> last7DaySales = [];
        if (shopController.dailySales.length > 6) {
          last7DaySales = shopController.dailySales.sublist(0, 7);
        } else {
          last7DaySales = shopController.dailySales;
        }

        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.lightGrey,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: BarChart(
              BarChartData(
                groupsSpace: 10,
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 58,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '\$${value.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkblue,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int mon = value.toInt() ~/ 100;
                        int day = value.toInt() % 100;
                        String d = '$mon.$day';
                        DateTime now = DateTime.now();
                        if (now.month == mon && now.day == day) {
                          d = 'Today';
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            d,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkblue,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  border: const Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                    right: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                ),
                barGroups: last7DaySales.map((e) {
                  return getBar(e.dateInInt, e.totalProfit);
                }).toList(),
                // barGroups: [
                //   getBar(0712, 60),
                //   getBar(0713, 1200),
                //   getBar(0714, 10),
                //   getBar(0715, 450),
                //   getBar(0716, 75),
                //   getBar(0717, 70),
                //   getBar(0718, 100),
                // ],
              ),
            ),
          ),
        );
      },
    );
  }

  BarChartGroupData getBar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.orange,
          width: 30,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ],
    );
  }
}
