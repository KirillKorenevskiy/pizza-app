import 'package:json_annotation/json_annotation.dart';

import 'macros_entity.dart';

part 'pizza_entity.g.dart';

@JsonSerializable()
class PizzaEntity {
  String pizzaId;
  String picture;
  bool isVegetarian;
  int spicy;
  String name;
  String description;
  int price;
  int discount;
  MacrosEntity macros;

  PizzaEntity({
    required this.pizzaId,
    required this.picture,
    required this.isVegetarian,
    required this.spicy,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.macros,
  });

  factory PizzaEntity.fromJson(Map<String, dynamic> json) => _$PizzaEntityFromJson(json);
}
