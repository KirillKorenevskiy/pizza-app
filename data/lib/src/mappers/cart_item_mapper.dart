import 'package:domain/domain.dart';

import '../entities/entities.dart';
import '../mappers/ingredients_mapper.dart';

class CartItemMapper {
  static CartItem fromEntity(
    CartItemEntity entity,
    Pizza pizza,
    List<IngredientEntity> ingredientEntities,
  ) {
    final List<Ingredient> ingredients =
        ingredientEntities.map(IngredientsMapper.fromEntity).toList();

    return CartItem(
      pizza: pizza,
      quantity: entity.quantity,
      additionalIngredients: ingredients,
    );
  }

  static CartItemEntity toEntity(CartItem model) {
    return CartItemEntity(
      id: model.pizza.pizzaId,
      quantity: model.quantity,
    );
  }
}
