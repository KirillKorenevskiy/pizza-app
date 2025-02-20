import '../../../domain.dart';
import '../use_case.dart';

class GetIngredientsByIdUseCase implements FutureUseCase<String, Ingredient> {
  final IngredientsRepository _ingredientsRepository;

  const GetIngredientsByIdUseCase(this._ingredientsRepository);

  @override
  Future<Ingredient> execute(String id) async {
    final Ingredient pizza = await _ingredientsRepository.getIngredientById(id);
    return pizza;
  }
}
