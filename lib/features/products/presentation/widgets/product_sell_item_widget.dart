import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/features/products/models/product_model.dart';

class ProductSellItemWidget extends StatelessWidget {
  final ProductModel product;
  final Function(int) onSelect;
  final int selectedProductId;
  const ProductSellItemWidget({
    super.key,
    required this.product,
    required this.onSelect,
    required this.selectedProductId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9),
      height: 74,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.lightGrey,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onSelect(product.id);
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 54,
                  width: 54,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(product.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 20,
                    ),
                    child: Text(
                      product.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.darkblue,
                  ),
                  padding: const EdgeInsets.all(7),
                  child: selectedProductId == product.id
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.orange,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
