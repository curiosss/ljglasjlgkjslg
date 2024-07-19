// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  int id;
  String name;
  double price;
  int inStock;
  String imagePath;
  int? soldAmount;
  DateTime? soldDate;
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.inStock,
    required this.imagePath,
    this.soldAmount,
    this.soldDate,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    int? inStock,
    String? imagePath,
    int? amountSold,
    DateTime? soldDate,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      inStock: inStock ?? this.inStock,
      imagePath: imagePath ?? this.imagePath,
      soldAmount: amountSold ?? this.soldAmount,
      soldDate: soldDate ?? this.soldDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'inStock': inStock,
      'imagePath': imagePath,
      'soldAmount': soldAmount,
      'soldDate': soldDate?.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      inStock: map['inStock'] ?? 0,
      imagePath: map['imagePath'] ?? '',
      soldAmount: map['soldAmount'] ?? 0,
      soldDate: map['soldDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['soldDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, inStock: $inStock, imagePath: $imagePath, amountSold: $soldAmount, soldDate: $soldDate)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.inStock == inStock &&
        other.imagePath == imagePath &&
        other.soldAmount == soldAmount &&
        other.soldDate == soldDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        inStock.hashCode ^
        imagePath.hashCode ^
        soldAmount.hashCode ^
        soldDate.hashCode;
  }
}
