class CartItemEntity {
  final String id;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.quantity,
  });

  CartItemEntity copyWith({
    required String? id,
    required int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
    );
  }
}
