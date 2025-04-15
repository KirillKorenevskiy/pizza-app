import 'package:json_annotation/json_annotation.dart';

part 'details_entity.g.dart';

@JsonSerializable()
class DetailsEntity {
  final String pizzaId;
  final String userId;
  final int size;
  final String ingredients;

  DetailsEntity({
    required this.pizzaId,
    required this.userId,
    required this.size,
    required this.ingredients,
  });

  factory DetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$DetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsEntityToJson(this);

  DetailsEntity copyWith({
    String? pizzaId,
    String? userId,
    int? size,
    String? ingredients,
  }) {
    return DetailsEntity(
      pizzaId: pizzaId ?? this.pizzaId,
      userId: userId ?? this.userId,
      size: size ?? this.size,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
