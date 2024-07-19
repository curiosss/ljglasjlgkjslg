// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CompanyInfoModel {
  String name;
  String imagePath;
  CompanyInfoModel({
    required this.name,
    required this.imagePath,
  });

  CompanyInfoModel copyWith({
    String? name,
    String? photo,
  }) {
    return CompanyInfoModel(
      name: name ?? this.name,
      imagePath: photo ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photo': imagePath,
    };
  }

  factory CompanyInfoModel.fromMap(Map<String, dynamic> map) {
    return CompanyInfoModel(
      name: map['name'] ?? '',
      imagePath: map['photo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyInfoModel.fromJson(String source) =>
      CompanyInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CompanyInfoModel(name: $name, photo: $imagePath)';

  @override
  bool operator ==(covariant CompanyInfoModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.imagePath == imagePath;
  }

  @override
  int get hashCode => name.hashCode ^ imagePath.hashCode;
}
