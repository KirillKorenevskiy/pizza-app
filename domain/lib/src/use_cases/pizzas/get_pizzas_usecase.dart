import '../../../domain.dart';
import '../use_case.dart';

class GetPizzasUseCase implements FutureUseCase<void, List<Pizza>> {
  final PizzaRepository _pizzaRepository;

  const GetPizzasUseCase(this._pizzaRepository);

  @override
  Future<List<Pizza>> execute([void input]) async {
    final List<Pizza> pizzas = await _pizzaRepository.getPizzas();

    return pizzas;
  }
}
