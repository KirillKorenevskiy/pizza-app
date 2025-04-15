class CartItemEntity {
  final String id;
  final int quantity;
  final String userId;

  const CartItemEntity({
    required this.id,
    required this.quantity,
    required this.userId,
  });

  CartItemEntity copyWith({
    required String? id,
    required int? quantity,
    required String? userId,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      userId: userId ?? this.userId,
    );
  }
}
