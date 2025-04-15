class UpdateQuantityPayload {
  final String cartId;
  final int quantity;
  final String userId;

  const UpdateQuantityPayload({
    required this.cartId,
    required this.quantity,
    required this.userId,
  });
}
