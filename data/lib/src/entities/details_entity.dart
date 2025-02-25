import 'package:json_annotation/json_annotation.dart';

part 'details_entity.g.dart';

@JsonSerializable()
class DetailsEntity {
  final String pizzaId;
  final int size;
  final String ingredients;

  DetailsEntity({
    required this.pizzaId,
    required this.size,
    required this.ingredients,
  });

  factory DetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$DetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsEntityToJson(this);

  DetailsEntity copyWith({
    String? pizzaId,
    int? size,
    String? ingredients,
  }) {
    return DetailsEntity(
      pizzaId: pizzaId ?? this.pizzaId,
      size: size ?? this.size,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
