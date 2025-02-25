class Details {
  final String pizzaId;
  final int size;
  final String? ingredients;

  Details({
    required this.pizzaId,
    required this.size,
    required this.ingredients,
  });

  Details copyWith({
    String? pizzaId,
    int? size,
    String? ingredients,
  }) {
    return Details(
      pizzaId: pizzaId ?? this.pizzaId,
      size: size ?? this.size,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
