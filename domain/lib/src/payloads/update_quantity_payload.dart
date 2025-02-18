class UpdateQuantityPayload {
  final String cartId;
  final int quantity;

  const UpdateQuantityPayload({
    required this.cartId,
    required this.quantity,
  });
}
