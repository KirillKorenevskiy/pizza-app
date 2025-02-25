import '../../../domain.dart';
import '../use_case.dart';

class GetIngredientsUseCase implements FutureUseCase<void, List<Ingredient>> {
  final IngredientsRepository _ingredientsRepository;

  const GetIngredientsUseCase(this._ingredientsRepository);

  @override
  Future<List<Ingredient>> execute([void input]) async {
    final List<Ingredient> pizzas =
        await _ingredientsRepository.getIngredients();

    return pizzas;
  }
}
