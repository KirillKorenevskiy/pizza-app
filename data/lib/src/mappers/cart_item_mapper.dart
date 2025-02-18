import 'package:domain/domain.dart';

import '../../data.dart';

class CartItemMapper {
  static CartItem fromEntity(CartItemEntity entity, Pizza pizza) {
    return CartItem(
      pizza: pizza,
      quantity: entity.quantity,
    );
  }

  static CartItemEntity toEntity(CartItem model) {
    return CartItemEntity(
      id: model.pizza.pizzaId,
      quantity: model.quantity,
    );
  }
}
