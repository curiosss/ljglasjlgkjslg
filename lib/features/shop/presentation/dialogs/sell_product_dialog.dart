import 'package:flutter/material.dart';
import 'package:t89/common/textfield/k_textfield.dart';
import 'package:t89/common/utils/snackbar_util.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/config/styles/dimens.dart';
import 'package:t89/core/widget_keys/widget_keys.dart';
import 'package:t89/features/products/controller/product_controller.dart';
import 'package:t89/features/products/models/product_model.dart';
import 'package:t89/features/products/presentation/widgets/product_sell_item_widget.dart';
import 'package:t89/features/shop/controller/shop_controller.dart';
import 'package:t89/injection_container.dart';

showSellProductDialog() {
  showDialog(
    context: rootNavKey.currentContext!,
    builder: (context) => const SellProductDialog(),
  );
}

class SellProductDialog extends StatefulWidget {
  const SellProductDialog({
    super.key,
  });

  @override
  State<SellProductDialog> createState() => _SellProductDialogState();
}

class _SellProductDialogState extends State<SellProductDialog> {
  ProductController productController = getIt<ProductController>();
  ShopController shopController = getIt<ShopController>();

  TextEditingController amountCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  int selectedProductId = 0;

  @override
  void initState() {
    selectedProductId = productController.products.first.id;
    super.initState();
  }

  @override
  void dispose() {
    amountCtrl.dispose();
    super.dispose();
  }

  bool validate() {
    bool isValid = true;
    if (!(formKey.currentState?.validate() ?? false)) {
      isValid = false;
    }
    return isValid;
  }

  sell() async {
    if (validate()) {
      int ind = productController.products
          .indexWhere((element) => element.id == selectedProductId);
      if (ind > -1) {
        ProductModel product = productController.products[ind];
        int? amount = int.tryParse(amountCtrl.text);

        if (amount == null || amount > product.inStock) {
          showSnackBarMessage('Not enough product in stock to sell!');
          return;
        }
        shopController.sell(product, amount);
        Navigator.pop(context);
      }
    }
  }

  cancel() {
    Navigator.pop(context);
  }

  onSelect(int productId) {
    setState(() {
      selectedProductId = productId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.marginM),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 260),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return ProductSellItemWidget(
                      product: productController.products[index],
                      onSelect: onSelect,
                      selectedProductId: selectedProductId,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: formKey,
                child: KTextfield(
                  controller: amountCtrl,
                  label: 'Amount',
                  textInputType: TextInputType.number,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Amount shouldn\'t be empty';
                    }
                    int? p = int.tryParse(p0);
                    if (p == null || p <= 0) {
                      return 'Enter valid amount value';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton(
                        onPressed: cancel,
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(4),
                          )),
                          side: const BorderSide(
                            width: 1,
                            color: AppColors.darkblue,
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkblue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: sell,
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(4),
                            right: Radius.circular(30),
                          )),
                        ),
                        child: const Text('Sell'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
