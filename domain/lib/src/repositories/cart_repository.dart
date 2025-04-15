import '../../domain.dart';

abstract interface class CartRepository {
  Stream<List<CartItem>> get cartStream;

  Future<List<CartItem>> getCarts(String userId);

  Future<void> addToCart(CartPayload payload);

  Future<void> removeFromCart(CartPayload payload);

  Future<bool> isInCart(CartPayload payload);

  Future<void> updateQuantity(UpdateQuantityPayload payload);

  Future<void> clearCart(String userId);
}
