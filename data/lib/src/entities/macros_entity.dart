import 'package:json_annotation/json_annotation.dart';

part 'macros_entity.g.dart';

@JsonSerializable()
class MacrosEntity {
  final int calories;
  final int proteins;
  final int fat;
  final int carbs;

  MacrosEntity({
    required this.calories,
    required this.proteins,
    required this.fat,
    required this.carbs,
  });

  factory MacrosEntity.fromJson(Map<String, dynamic> json) => _$MacrosEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MacrosEntityToJson(this);

  MacrosEntity copyWith({
    int? calories,
    int? proteins,
    int? fat,
    int? carbs,
  }) {
    return MacrosEntity(
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
    );
  }
}
