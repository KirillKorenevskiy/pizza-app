import '../../domain.dart';

abstract interface class CartRepository {
  Stream<List<CartItem>> get cartStream;

  Future<List<CartItem>> getCarts();

  Future<void> addToCart(String pizzaId);

  Future<void> removeFromCart(String pizzaId);

  Future<bool> isInCart(String pizzaId);

  Future<void> updateQuantity(UpdateQuantityPayload payload);
}
