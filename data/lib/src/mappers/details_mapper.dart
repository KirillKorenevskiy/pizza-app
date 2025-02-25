import 'package:domain/domain.dart';

import '../../data.dart';

class DetailsMapper {
  static Details fromEntity(DetailsEntity entity) {
    return Details(
      pizzaId: entity.pizzaId,
      size: entity.size,
      ingredients: entity.ingredients,
    );
  }

  static DetailsEntity toEntity(Details model) {
    return DetailsEntity(
      pizzaId: model.pizzaId,
      size: model.size,
      ingredients: model.ingredients ?? '',
    );
  }
}
