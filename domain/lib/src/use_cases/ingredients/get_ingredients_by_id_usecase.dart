import '../../../domain.dart';
import '../use_case.dart';

class GetIngredientsByIdUseCase implements FutureUseCase<String, Ingredient> {
  final IngredientsRepository _ingredientsRepository;

  const GetIngredientsByIdUseCase(this._ingredientsRepository);

  @override
  Future<Ingredient> execute(String input) async {
    final Ingredient pizza = await _ingredientsRepository.getIngredientById(input);
    return pizza;
  }
}
