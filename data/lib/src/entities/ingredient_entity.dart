import 'package:json_annotation/json_annotation.dart';

part 'ingredient_entity.g.dart';

@JsonSerializable()
class IngredientEntity {
  final String id;
  final String name;
  final double price;
  final String image;

  IngredientEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory IngredientEntity.fromJson(Map<String, dynamic> json) =>
      _$IngredientEntityFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientEntityToJson(this);

  IngredientEntity copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
  }) {
    return IngredientEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }
}
