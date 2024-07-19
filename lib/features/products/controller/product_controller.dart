import 'package:flutter/material.dart';
import 'package:t89/common/utils/file_utils.dart';
import 'package:t89/core/storage/storage_hive.dart';
import 'package:t89/features/products/models/product_model.dart';
import 'package:t89/injection_container.dart';

class ProductController with ChangeNotifier {
  StorageHive storageHive = getIt<StorageHive>();
  List<ProductModel> products = [];

  int productsInStock = 0;

  init() async {
    try {
      List<String>? res = storageHive.box?.get('products');
      if (res != null) {
        products =
            List<ProductModel>.from(res.map((e) => ProductModel.fromJson(e)));

        productsInStock = 0;
        if (products.isNotEmpty) {
          for (var product in products) {
            productsInStock += product.inStock;
          }
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  reset() {
    products.clear();
    productsInStock = 0;
    notifyListeners();
    storageHive.box?.delete('products');
  }

  _saveProducts() async {
    await storageHive.box
        ?.put('products', products.map((e) => e.toJson()).toList());
  }

  addProduct(ProductModel product) async {
    try {
      product.imagePath = await saveFile(product.imagePath, null);
      products.add(product);
      productsInStock += product.inStock;
      notifyListeners();
      await _saveProducts();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateProduct(ProductModel product) async {
    try {
      int ind = products.indexWhere((element) => element.id == product.id);
      if (ind > -1) {
        ProductModel oldProd = products[ind];
        if (oldProd.imagePath != product.imagePath) {
          product.imagePath =
              await saveFile(product.imagePath, oldProd.imagePath);
        }

        productsInStock -= products[ind].inStock;
        productsInStock += product.inStock;
        products[ind] = product;

        notifyListeners();

        await _saveProducts();
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> deleteProduct(ProductModel product) async {
    try {
      int ind = products.indexWhere((element) => element.id == product.id);
      if (ind > -1) {
        await deleteFile(products[ind].imagePath);
        productsInStock -= products[ind].inStock;
        products.removeAt(ind);
        notifyListeners();
        await _saveProducts();
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  bool checkProductsInStock() {
    return products.isNotEmpty;
  }

  removeProductFromStock(int productId, int amount) {
    int ind = products.indexWhere((element) => element.id == productId);
    if (ind > -1) {
      products[ind].inStock -= amount;
      productsInStock -= amount;
      notifyListeners();
      _saveProducts();
    }
  }
}
