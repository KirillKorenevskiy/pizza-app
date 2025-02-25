import '../../../domain.dart';
import '../use_case.dart';

class GetPizzaByIdUseCase implements FutureUseCase<String, Pizza> {
  final PizzaRepository _pizzaRepository;

  const GetPizzaByIdUseCase(this._pizzaRepository);

  @override
  Future<Pizza> execute(String input) async {
    final Pizza pizza = await _pizzaRepository.getPizzaById(input);

    return pizza;
  }
}
