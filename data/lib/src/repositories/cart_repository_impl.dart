import 'package:domain/domain.dart';

import '../../data.dart';

class CartRepositoryImpl implements CartRepository {
  final LocalCartProvider _cartProvider;
  final RemotePizzaProvider _pizzaProvider;

  const CartRepositoryImpl(
    this._cartProvider,
    this._pizzaProvider,
  );

  @override
  Stream<List<CartItem>> get cartStream => _cartProvider.cartStream.asyncMap(
        (List<CartItemEntity> cartItemEntities) async {
          final List<PizzaEntity> pizzaEntities = await Future.wait(
            cartItemEntities.map(
              (CartItemEntity cartItemEntity) async {
                return _pizzaProvider.getPizzaById(cartItemEntity.id);
              },
            ),
          );

          return List<CartItem>.generate(
            cartItemEntities.length,
            (int index) {
              final Pizza pizza = PizzaMapper.fromEntity(pizzaEntities[index]);
              return CartItemMapper.fromEntity(
                cartItemEntities[index],
                pizza,
              );
            },
          );
        },
      );

  @override
  Future<void> addToCart(String pizzaId) {
    final CartItemEntity entity = CartItemEntity(
      id: pizzaId,
      quantity: 1,
    );

    return _cartProvider.addToCart(entity);
  }

  @override
  Future<List<CartItem>> getCarts() async {
    final List<CartItemEntity> entities = await _cartProvider.getCarts();
    final List<PizzaEntity> pizzaEntities = await Future.wait(
      entities.map(
        (CartItemEntity entity) => _pizzaProvider.getPizzaById(entity.id),
      ),
    );
    return List<CartItem>.generate(
      entities.length,
      (int index) {
        final Pizza pizza = PizzaMapper.fromEntity(pizzaEntities[index]);
        final CartItem cartItem = CartItemMapper.fromEntity(
          entities[index],
          pizza,
        );

        return cartItem;
      },
    );
  }

  @override
  Future<bool> isInCart(String pizzaId) async {
    return _cartProvider.isInCart(pizzaId);
  }

  @override
  Future<void> removeFromCart(String pizzaId) async {
    await _cartProvider.removeFromCart(pizzaId);
  }

  @override
  Future<void> updateQuantity(UpdateQuantityPayload payload) async {
    await _cartProvider.updateQuantity(payload.cartId, payload.quantity);
  }
}
