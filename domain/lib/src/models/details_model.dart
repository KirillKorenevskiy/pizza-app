class Details {
  final String pizzaId;
  final String userId;
  final int size;
  final String? ingredients;

  Details({
    required this.pizzaId,
    required this.userId,
    required this.size,
    required this.ingredients,
  });

  Details copyWith({
    String? pizzaId,
    String? userId,
    int? size,
    String? ingredients,
  }) {
    return Details(
      pizzaId: pizzaId ?? this.pizzaId,
      userId: userId ?? this.userId,
      size: size ?? this.size,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
