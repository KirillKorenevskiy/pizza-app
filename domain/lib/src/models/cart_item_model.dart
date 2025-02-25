import '../../domain.dart';

class CartItem {
  final Pizza pizza;
  final int quantity;
  final List<Ingredient> additionalIngredients;

  const CartItem({
    required this.pizza,
    required this.quantity,
    this.additionalIngredients = const <Ingredient>[],
  });

  CartItem copyWith({
    Pizza? pizza,
    int? quantity,
    List<Ingredient>? additionalIngredients,
  }) {
    return CartItem(
      pizza: pizza ?? this.pizza,
      quantity: quantity ?? this.quantity,
      additionalIngredients:
          additionalIngredients ?? this.additionalIngredients,
    );
  }

  double get totalPrice {
    final double pizzaPrice = pizza.price * (1 - (pizza.discount / 100));

    final double additionalIngredientsCost = additionalIngredients.fold(
      0.0,
      (double sum, Ingredient ingredient) => sum + ingredient.price,
    );

    return (pizzaPrice + additionalIngredientsCost) * quantity;
  }
}
