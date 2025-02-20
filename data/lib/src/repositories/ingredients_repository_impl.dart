import 'package:domain/domain.dart';

import '../../data.dart';

class IngredientsRepositoryImpl implements IngredientsRepository {
  final RemoteIngredientsProvider _ingredientsProvider;

  const IngredientsRepositoryImpl(
    this._ingredientsProvider,
  );

  @override
  Future<List<Ingredient>> getIngredients() async {
    final List<IngredientEntity> entities =
        await _ingredientsProvider.getIngredients();

    return entities.map(IngredientsMapper.fromEntity).toList();
  }

  @override
  Future<Ingredient> getIngredientById(String id) async{
    final IngredientEntity entity =
        await _ingredientsProvider.getIngredientById(id);

    return IngredientsMapper.fromEntity(entity);
  }
}
