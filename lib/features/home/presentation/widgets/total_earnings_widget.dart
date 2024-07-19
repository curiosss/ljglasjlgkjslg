import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/config/styles/textstyles.dart';
import 'package:t89/features/products/controller/product_controller.dart';
import 'package:t89/features/shop/controller/shop_controller.dart';
import 'package:t89/injection_container.dart';

class TotalEarningsWidget extends StatelessWidget {
  const TotalEarningsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ShopController shopController = getIt<ShopController>();
    ProductController productController = getIt<ProductController>();
    return ListenableBuilder(
      listenable: shopController,
      builder: (context, _) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.lightGrey,
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Earnings',
                style: AppTextStyles.f15w500.copyWith(
                  color: AppColors.darkblue40,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 15,
                ),
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: AppColors.green,
                  ),
                  color: const Color(0x3386F984),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      '\$',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        shopController.totalEarnings.toStringAsFixed(2),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0x0d000000),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildItem(
                    label: 'Best sale:',
                    value: '\$ ${shopController.bestSale.toStringAsFixed(0)}',
                    color: AppColors.green,
                  ),
                  ListenableBuilder(
                      listenable: productController,
                      builder: (context, _) {
                        return buildItem(
                          label: 'Products in stock:',
                          value: productController.productsInStock.toString(),
                        );
                      }),
                  buildItem(
                    label: 'Products sold:',
                    value: shopController.productsSold.toString(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildItem({
    required String label,
    required String value,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
