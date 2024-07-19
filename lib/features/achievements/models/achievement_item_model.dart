// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AchievementItemModel {
  bool isAchieved;
  String name;
  String status;
  AchievementItemModel({
    required this.isAchieved,
    required this.name,
    required this.status,
  });

  AchievementItemModel copyWith({
    bool? isAchieved,
    String? name,
    String? status,
  }) {
    return AchievementItemModel(
      isAchieved: isAchieved ?? this.isAchieved,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isAchieved': isAchieved,
      'name': name,
      'status': status,
    };
  }

  factory AchievementItemModel.fromMap(Map<String, dynamic> map) {
    return AchievementItemModel(
      isAchieved: map['isAchieved'] ?? false,
      name: map['name'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AchievementItemModel.fromJson(String source) =>
      AchievementItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AchievementItemModel(isAchieved: $isAchieved, name: $name, status: $status)';

  @override
  bool operator ==(covariant AchievementItemModel other) {
    if (identical(this, other)) return true;

    return other.isAchieved == isAchieved &&
        other.name == name &&
        other.status == status;
  }

  @override
  int get hashCode => isAchieved.hashCode ^ name.hashCode ^ status.hashCode;
}
