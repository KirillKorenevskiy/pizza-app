import '../../domain.dart';

abstract class IngredientsRepository {
  Future<List<Ingredient>> getIngredients();

  Future<Ingredient> getIngredientById(String id);
}
