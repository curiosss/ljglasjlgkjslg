import 'package:t89/features/products/models/product_model.dart';

class DaySalesModel {
  DateTime date;
  List<ProductModel> soldProducts;
  int dateInInt = 0;
  double totalProfit = 0;

  DaySalesModel({
    required this.date,
    required this.soldProducts,
  }) {
    dateInInt = date.month * 100 + date.day;
  }
}
