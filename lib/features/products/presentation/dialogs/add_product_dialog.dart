import 'package:flutter/material.dart';
import 'package:t89/common/buttons/k_elevated_button.dart';
import 'package:t89/common/textfield/k_textfield.dart';
import 'package:t89/common/widgets/add_photo_widget.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/config/styles/dimens.dart';
import 'package:t89/core/widget_keys/widget_keys.dart';
import 'package:t89/features/products/controller/product_controller.dart';
import 'package:t89/features/products/models/product_model.dart';
import 'package:t89/injection_container.dart';

showProductDialog({ProductModel? product, required bool showCancelBtn}) {
  showDialog(
    context: rootNavKey.currentContext!,
    builder: (context) => AddProductDialog(
      product: product,
      showCancelBtn: showCancelBtn,
    ),
  );
}

class AddProductDialog extends StatefulWidget {
  final ProductModel? product;
  final bool showCancelBtn;
  const AddProductDialog({
    super.key,
    this.product,
    required this.showCancelBtn,
  });

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController inStockCtrl = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<AddPhotoWidgetState> addPhotoWidgetKey = GlobalKey();

  @override
  void initState() {
    if (widget.product != null) {
      nameCtrl.text = widget.product!.name;
      priceCtrl.text = widget.product!.price.toStringAsFixed(2);
      inStockCtrl.text = widget.product!.inStock.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    priceCtrl.dispose();
    inStockCtrl.dispose();

    super.dispose();
  }

  bool validate() {
    bool isValid = true;
    if (!(formKey.currentState?.validate() ?? false)) {
      isValid = false;
    }

    if (!(addPhotoWidgetKey.currentState?.validate() ?? false)) {
      isValid = false;
    }
    return isValid;
  }

  save() async {
    if (validate()) {
      ProductModel p = ProductModel(
        id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch,
        name: nameCtrl.text,
        price: double.parse(priceCtrl.text.replaceAll(',', '.')),
        inStock: int.parse(inStockCtrl.text),
        imagePath: addPhotoWidgetKey.currentState!.selectedImage!.path,
      );
      late bool res;
      if (widget.product != null) {
        res = await getIt<ProductController>().updateProduct(p);
      } else {
        res = await getIt<ProductController>().addProduct(p);
      }

      if (res && mounted) {
        Navigator.pop(context);
      }
    }
  }

  cancel() {
    Navigator.pop(context);
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
              Form(
                key: formKey,
                child: Column(
                  children: [
                    KTextfield(
                      controller: nameCtrl,
                      label: 'Product Name',
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Product Name shouldn\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 17),
                    KTextfield(
                      controller: priceCtrl,
                      label: 'Product Price',
                      textInputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Product Price shouldn\'t be empty';
                        }
                        double? p = double.tryParse(p0.replaceFirst(',', '.'));
                        if (p == null || p <= 0) {
                          return 'Enter valid price';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 17),
                    KTextfield(
                      controller: inStockCtrl,
                      label: 'Product in stock',
                      textInputType: TextInputType.number,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'In stock shouldn\'t be empty';
                        }
                        int? p = int.tryParse(p0);
                        if (p == null || p <= 0) {
                          return 'Enter valid in stock value';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              AddPhotoWidget(
                key: addPhotoWidgetKey,
                imagePath: widget.product?.imagePath,
              ),
              widget.showCancelBtn
                  ? Row(
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
                              onPressed: save,
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(4),
                                  right: Radius.circular(30),
                                )),
                              ),
                              child: const Text('Save'),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 44,
                      width: double.infinity,
                      child: KElevatedButton(
                        onPressed: save,
                        title: 'Save',
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
