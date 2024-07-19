import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t89/common/utils/snackbar_util.dart';
import 'package:t89/common/widgets/k_appbar.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/config/styles/textstyles.dart';
import 'package:t89/features/home/presentation/widgets/most_profitable_product.dart';
import 'package:t89/features/home/presentation/widgets/total_earnings_widget.dart';
import 'package:t89/features/products/controller/product_controller.dart';
import 'package:t89/features/products/presentation/dialogs/add_product_dialog.dart';
import 'package:t89/features/settings/controllers/settings_controller.dart';
import 'package:t89/features/settings/presentation/dialogs/add_companyinfo_dialog.dart';
import 'package:t89/features/shop/presentation/dialogs/sell_product_dialog.dart';
import 'package:t89/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController productController = getIt<ProductController>();

  bool canShowDialog = true;
  @override
  didChangeDependencies() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (getIt<SettingsController>().companyInfo == null) {
      canShowDialog = false;
      showCompanyInfoDialog(
        barrierDissmissable: false,
      );
    }
    super.didChangeDependencies();
  }

  onTapAddProduct() {
    showProductDialog(showCancelBtn: false);
  }

  onTapSellProduct() {
    if (!productController.checkProductsInStock()) {
      showSnackBarMessage('No products in stock to sell');
      return;
    }
    showSellProductDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(
        iconPath: 'assets/navbar_icons/home.svg',
        title: 'MAIN',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: onTapAddProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkblue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30),
                        right: Radius.circular(4),
                      ),
                    ),
                  ),
                  icon: SvgPicture.asset('assets/icons/box.svg'),
                  label: const Text(
                    'Add a Product',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.f15w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 1),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: onTapSellProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkblue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(4),
                        right: Radius.circular(30),
                      ),
                    ),
                  ),
                  icon: SvgPicture.asset('assets/icons/shopping-cart.svg'),
                  label: const Text(
                    'Add a Sale',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.f15w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          children: [
            MostProfitableProduct(),
            TotalEarningsWidget(),
          ],
        ),
      ),
    );
  }
}
