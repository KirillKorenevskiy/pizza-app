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
    final List<PizzaEntity> pizzaEntities = await Future.wait(
      cartItemEntities.map(
        (CartItemEntity entity) => _pizzaProvider.getPizzaById(entity.id),
      ),
    );

    final List<DetailsEntity?> detailsEntities = await Future.wait(
      cartItemEntities.map(
        (CartItemEntity entity) => _detailsProvider.getDetailById(entity.id),
      ),
    );

    final List<IngredientEntity> ingredientEntities =
        await _ingredientsProvider.getIngredients();

    return List<CartItem>.generate(
      cartItemEntities.length,
      (int index) {
        final Pizza pizza = PizzaMapper.fromEntity(pizzaEntities[index]);
        final DetailsEntity? details = detailsEntities[index];

        List<IngredientEntity> ingredients = <IngredientEntity>[];
        if (details != null && details.ingredients.isNotEmpty) {
          final List<String> ingredientNames = details.ingredients
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
  Future<List<CartItem>> getCarts() async {
    final List<CartItemEntity> entities = await _cartProvider.getCarts();
    return _mapCartItems(entities);
  }

  @override
  Stream<List<CartItem>> get cartStream => _cartProvider.cartStream.asyncMap(
        (List<CartItemEntity> cartItemEntities) async {
          return _mapCartItems(cartItemEntities);
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
  Future<bool> isInCart(String pizzaId) async {
    return _cartProvider.isInCart(pizzaId);
  }

  @override
  Future<void> removeFromCart(String pizzaId) async {
    await _cartProvider.removeFromCart(pizzaId);
  }

  @override
  Future<void> updateQuantity(UpdateQuantityPayload payload) async {
    await _cartProvider.updateQuantity(
      payload.cartId,
      payload.quantity,
    );
  }
}
