import 'macros_model.dart';

class Pizza {
  final String pizzaId;
  final String picture;
  final bool isVegetarian;
  final int spicy;
  final String name;
  final String description;
  final int price;
  final int discount;
  Macros macros;

  Pizza({
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

  Pizza copyWith({
    String? pizzaId,
    String? picture,
    bool? isVegetarian,
    int? spicy,
    String? name,
    String? description,
    int? price,
    int? discount,
    Macros? macros,
  }) {
    return Pizza(
      pizzaId: pizzaId ?? this.pizzaId,
      picture: picture ?? this.picture,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      spicy: spicy ?? this.spicy,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      macros: macros ?? this.macros,
    );
  }
}
