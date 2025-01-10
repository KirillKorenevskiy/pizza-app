import 'package:domain/domain.dart';

import '../entities/macros_entity.dart';

class MacrosMapper {
  static Macros fromEntity(MacrosEntity entity) {
    return Macros(
      calories: entity.calories,
      proteins: entity.proteins,
      fat: entity.fat,
      carbs: entity.carbs,
    );
  }

  static MacrosEntity toEntity(Macros model) {
    return MacrosEntity(
      calories: model.calories,
      proteins: model.proteins,
      fat: model.fat,
      carbs: model.carbs,
    );
  }
}
