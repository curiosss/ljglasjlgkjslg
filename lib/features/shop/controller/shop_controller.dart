import 'package:flutter/material.dart';
import 'package:t89/common/utils/date_utils.dart';
import 'package:t89/core/storage/storage_hive.dart';
import 'package:t89/features/achievements/data/achievements_data.dart';
import 'package:t89/features/achievements/models/achievement_model.dart';
import 'package:t89/features/products/controller/product_controller.dart';
import 'package:t89/features/products/models/product_model.dart';
import 'package:t89/features/shop/models/day_sales_model.dart';
import 'package:t89/injection_container.dart';

class ShopController with ChangeNotifier {
  StorageHive storageHive = getIt<StorageHive>();
  ProductController productController = getIt<ProductController>();

  ProductModel? mostProfitableProduct;
  double totalEarnings = 0;
  double bestSale = 0;
  int productsSold = 0;

  List<ProductModel> soldProducts = [];
  List<ProductModel> productsBySale = [];
  List<DaySalesModel> dailySales = [];

  List<AchievementModel> achievements = AchievementsData.achievements;

  init() async {
    List<String>? data = storageHive.box?.get('soldProducts');
    if (data != null) {
      soldProducts = List<ProductModel>.from(
        data.map((e) => ProductModel.fromJson(e)),
      );

      _calculateStats();
    }
  }

  reset() {
    soldProducts.clear();
    productsBySale.clear();
    dailySales.clear();
    mostProfitableProduct = null;
    totalEarnings = 0;
    bestSale = 0;
    productsSold = 0;
    notifyListeners();
    storageHive.box?.delete('soldProducts');
  }

  _saveSoldProducts() {
    storageHive.box?.put(
      'soldProducts',
      List<String>.from(soldProducts.map((e) => e.toJson())),
    );
  }

  sell(ProductModel product, int amount) async {
    product.soldDate = DateTime.now();
    product.soldAmount = amount;
    soldProducts.add(product);
    _saveSoldProducts();
    _addProductToStats(product, amount);
  }

  _calculateStats() {
    productsSold = 0;
    totalEarnings = 0;
    if (soldProducts.isNotEmpty) {
      bestSale = soldProducts.first.price * soldProducts.first.soldAmount!;
      for (var soldProduct in soldProducts) {
        double profit = soldProduct.soldAmount! * soldProduct.price;
        if (bestSale < profit) {
          bestSale = profit;
        }

        productsSold += soldProduct.soldAmount!;
        totalEarnings += profit;

        _addToBySale(soldProduct);
      }
      _findMostProfitableProduct();
    }

    _calculateAchievements();

    notifyListeners();
  }

  _addProductToStats(ProductModel product, int amount) {
    productController.removeProductFromStock(product.id, amount);

    double profit = product.price * amount;
    if (bestSale < profit) {
      bestSale = profit;
    }

    totalEarnings += profit;
    productsSold += amount;

    _addToBySale(product);
    _findMostProfitableProduct();
    _calculateAchievements();
    notifyListeners();
  }

  _addToBySale(ProductModel product) {
    _addToDailySales(product);

    int ind = productsBySale.indexWhere((element) => element.id == product.id);
    if (ind > -1) {
      productsBySale[ind].soldAmount !=
          productsBySale[ind].soldAmount! + product.soldAmount!;
    } else {
      productsBySale.add(product);
    }
  }

  _addToDailySales(ProductModel product) {
    DateTime soldDate = product.soldDate!;
    int ind = dailySales
        .indexWhere((element) => isDatesSameDay(element.date, soldDate));
    if (ind > -1) {
      dailySales[ind].soldProducts.add(product);
      dailySales[ind].totalProfit += (product.soldAmount! * product.price);
    } else {
      dailySales.insert(
          0,
          DaySalesModel(
            date: soldDate,
            soldProducts: [product],
          ));
    }
  }

  _findMostProfitableProduct() {
    mostProfitableProduct = null;
    if (productsBySale.isNotEmpty) {
      double maxProfit = 0, profit = 0;
      for (var product in productsBySale) {
        profit = product.soldAmount! * product.price;
        if (profit > maxProfit) {
          maxProfit = profit;
          mostProfitableProduct = product;
        }
      }
    }
  }

  _calculateAchievements() {
    achievements = List.from(AchievementsData.achievements);
    for (var achievement in achievements) {
      switch (achievement.position) {
        case AchievementPosition.rookie:
          bool isAchieved = true;
          for (int i = 0; i < achievement.items.length; i++) {
            if (i == 0) {
              if (soldProducts.isNotEmpty) {
                achievement.items[0].isAchieved = true;
              } else {
                isAchieved = false;
              }
            } else if (i == 1) {
              if (totalEarnings >= 1) {
                achievement.items[1].isAchieved = true;
              } else {
                isAchieved = false;
              }
            }
            achievement.isAchieved = isAchieved;
          }
          break;
        case AchievementPosition.advanced:
          bool isAchieved = true;
          for (int i = 0; i < achievement.items.length; i++) {
            if (i == 0) {
              if (productsSold > 49) {
                achievement.items[0].isAchieved = true;
              } else {
                isAchieved = false;
                achievement.items[0].status = '$productsSold/50';
              }
            } else if (i == 1) {
              if (totalEarnings >= 1000) {
                achievement.items[1].isAchieved = true;
              } else {
                isAchieved = false;
                achievement.items[1].status =
                    '${totalEarnings.toStringAsFixed(0)}/1000';
              }
            }
            achievement.isAchieved = isAchieved;
          }
          break;

        default:
          break;
      }
    }
  }
}
