import 'package:domain/domain.dart';

import '../../data.dart';

class IngredientsMapper {
  static Ingredient fromEntity(IngredientEntity entity) {
    return Ingredient(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      image: entity.image,
    );
  }

  static IngredientEntity toEntity(Ingredient model) {
    return IngredientEntity(
      id: model.id,
      name: model.name,
      price: model.price,
      image: model.image,
    );
  }
}
