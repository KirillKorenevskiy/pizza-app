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
          _detailsProvider.getDetailById(entity.id),
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
