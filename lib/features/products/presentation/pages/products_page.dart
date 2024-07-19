import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t89/common/widgets/k_appbar.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/config/styles/textstyles.dart';
import 'package:t89/features/products/controller/product_controller.dart';
import 'package:t89/features/products/presentation/dialogs/add_product_dialog.dart';
import 'package:t89/features/products/presentation/widgets/product_item_widget.dart';
import 'package:t89/injection_container.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductController productController = getIt<ProductController>();

  onTapAddProduct() {
    showProductDialog(showCancelBtn: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(
        iconPath: 'assets/navbar_icons/bag.svg',
        title: 'PRODUCTS',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 10,
        ),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onTapAddProduct,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkblue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
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
      body: ListenableBuilder(
        listenable: productController,
        builder: (context, _) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 7.5,
            ),
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              return ProductItemWidget(
                product: productController.products[index],
              );
            },
          );
        },
      ),
    );
  }
}
