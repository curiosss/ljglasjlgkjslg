import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/config/styles/textstyles.dart';
import 'package:t89/features/shop/controller/shop_controller.dart';
import 'package:t89/injection_container.dart';

class MostProfitableProduct extends StatelessWidget {
  const MostProfitableProduct({super.key});

  @override
  Widget build(BuildContext context) {
    ShopController shopController = getIt<ShopController>();
    return ListenableBuilder(
      listenable: shopController,
      builder: (context, _) {
        if (shopController.mostProfitableProduct == null) {
          return const SizedBox();
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.lightGrey,
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Most Profitable Product',
                      style: AppTextStyles.f15w500.copyWith(
                        color: AppColors.darkblue40,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/arrow_right.svg',
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Text(
                shopController.mostProfitableProduct!.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total profit:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '\$ ${(shopController.mostProfitableProduct!.soldAmount! * shopController.mostProfitableProduct!.price).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sold:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      shopController.mostProfitableProduct!.soldAmount!
                          .toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkblue,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 181,
                margin: const EdgeInsets.only(top: 16),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(shopController.mostProfitableProduct!.imagePath),
                    errorBuilder: (context, error, stackTrace) {
                      return SvgPicture.asset('assets/icons/camera.svg');
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
