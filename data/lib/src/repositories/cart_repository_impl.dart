import 'package:domain/domain.dart';

import '../../data.dart';

class CartRepositoryImpl implements CartRepository {
  final LocalCartProvider _cartProvider;
  final RemotePizzaProvider _pizzaProvider;
  final LocalDetailsProvider _detailsProvider;
  final RemoteIngredientsProvider _ingredientsProvider;

  const CartRepositoryImpl(
    this._cartProvider,
    this._pizzaProvider,
    this._detailsProvider,
    this._ingredientsProvider,
  );

  Future<List<CartItem>> _mapCartItems(
    List<CartItemEntity> cartItemEntities,
  ) async {
    final List<dynamic> results = await Future.wait(
      cartItemEntities.expand(
        (CartItemEntity entity) => <Future<dynamic>>[
          _pizzaProvider.getPizzaById(entity.id),
          _detailsProvider.getDetailById(
            entity.id,
            entity.userId,
          ),
        ],
      ),
    );

    final List<IngredientEntity> ingredientEntities =
        await _ingredientsProvider.getIngredients();

    return List<CartItem>.generate(
      cartItemEntities.length,
      (int index) {
        final PizzaEntity pizzaEntity = results[index * 2] as PizzaEntity;
        final DetailsEntity? detailsEntity =
            results[index * 2 + 1] as DetailsEntity?;

        final Pizza pizza = PizzaMapper.fromEntity(pizzaEntity);

        List<IngredientEntity> ingredients = <IngredientEntity>[];
        if (detailsEntity != null && detailsEntity.ingredients.isNotEmpty) {
          final List<String> ingredientNames = detailsEntity.ingredients
              .split(',')
              .map((String e) => e.trim())
              .toList();
          ingredients = ingredientEntities.where((IngredientEntity ingredient) {
            return ingredientNames.contains(ingredient.name);
          }).toList();
        }

        return CartItemMapper.fromEntity(
          cartItemEntities[index],
          pizza,
          ingredients,
        );
      },
    );
  }

  @override
  Future<List<CartItem>> getCarts(String userId) async {
    final List<CartItemEntity> entities = await _cartProvider.getCarts(userId);
    return _mapCartItems(entities);
  }

  @override
  Stream<List<CartItem>> get cartStream => _cartProvider.cartStream.asyncMap(
        (List<CartItemEntity> cartItemEntities) async {
          return _mapCartItems(cartItemEntities);
        },
      );

  @override
  Future<void> addToCart(CartPayload payload) {
    final CartItemEntity entity = CartItemEntity(
      id: payload.pizzaId,
      quantity: 1,
      userId: payload.userId,
    );

    return _cartProvider.addToCart(entity);
  }

  @override
  Future<bool> isInCart(CartPayload payload) async {
    return _cartProvider.isInCart(payload.pizzaId, payload.userId);
  }

  @override
  Future<void> removeFromCart(CartPayload payload) async {
    await _cartProvider.removeFromCart(payload.pizzaId, payload.userId);
  }

  @override
  Future<void> updateQuantity(UpdateQuantityPayload payload) async {
    await _cartProvider.updateQuantity(
      payload.cartId,
      payload.quantity,
      payload.userId,
    );
  }

  @override
  Future<void> clearCart(String userId) async {
    await _cartProvider.clearCart(userId);
  }
}
