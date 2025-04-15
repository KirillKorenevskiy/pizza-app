import 'package:domain/domain.dart';

import '../../data.dart';

class DetailsMapper {
  static Details fromEntity(DetailsEntity entity) {
    return Details(
      pizzaId: entity.pizzaId,
      userId: entity.userId,
      size: entity.size,
      ingredients: entity.ingredients,
    );
  }

  static DetailsEntity toEntity(Details model) {
    return DetailsEntity(
      pizzaId: model.pizzaId,
      userId: model.userId,
      size: model.size,
      ingredients: model.ingredients ?? '',
    );
  }
}
