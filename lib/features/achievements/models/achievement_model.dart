// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:t89/features/achievements/data/achievements_data.dart';
import 'package:t89/features/achievements/models/achievement_item_model.dart';

class AchievementModel {
  AchievementPosition position;
  bool isAchieved;
  String name;
  List<AchievementItemModel> items;
  AchievementModel({
    required this.position,
    required this.isAchieved,
    required this.name,
    required this.items,
  });

  AchievementModel copyWith({
    AchievementPosition? achievementPosition,
    bool? isAchieved,
    String? name,
    List<AchievementItemModel>? items,
  }) {
    return AchievementModel(
      position: achievementPosition ?? this.position,
      isAchieved: isAchieved ?? this.isAchieved,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': position.index,
      'isAchieved': isAchieved,
      'name': name,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory AchievementModel.fromMap(Map<String, dynamic> map) {
    return AchievementModel(
      position: AchievementPosition.values[map['position'] ?? 0],
      isAchieved: map['isAchieved'] ?? false,
      name: map['name'] ?? '',
      items: List<AchievementItemModel>.from(
        (map['items'] as List<int>).map<AchievementItemModel>(
          (x) => AchievementItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AchievementModel.fromJson(String source) =>
      AchievementModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AchievementModel(achievementPosition: $position, isAchieved: $isAchieved, name: $name, items: $items)';
  }

  @override
  bool operator ==(covariant AchievementModel other) {
    if (identical(this, other)) return true;

    return other.position == position &&
        other.isAchieved == isAchieved &&
        other.name == name &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return position.hashCode ^
        isAchieved.hashCode ^
        name.hashCode ^
        items.hashCode;
  }
}
