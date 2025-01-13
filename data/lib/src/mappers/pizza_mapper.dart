import 'package:domain/domain.dart';
import '../../data.dart';

class PizzaMapper {
  static Pizza fromEntity(PizzaEntity entity) {
    return Pizza(
      pizzaId: entity.pizzaId,
      picture: entity.picture,
      isVeg: entity.isVegetarian,
      spicy: entity.spicy,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      discount: entity.discount,
      macros: MacrosMapper.fromEntity(entity.macros),
    );
  }

  static PizzaEntity toEntity(Pizza model) {
    return PizzaEntity(
      pizzaId: model.pizzaId,
      picture: model.picture,
      isVegetarian: model.isVeg,
      spicy: model.spicy,
      name: model.name,
      description: model.description,
      price: model.price,
      discount: model.discount,
      macros: MacrosMapper.toEntity(model.macros),
    );
  }
}
