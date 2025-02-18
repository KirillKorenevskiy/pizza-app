import '../../domain.dart';

class CartItem {
  final Pizza pizza;
  final int quantity;

  const CartItem({
    required this.pizza,
    required this.quantity,
  });

  CartItem copyWith({
    Pizza? pizza,
    int? quantity,
  }) {
    return CartItem(
      pizza: pizza ?? this.pizza,
      quantity: quantity ?? this.quantity,
    );
  }
}
