import 'package:domain/domain.dart';
import '../providers/pizza_provider.dart';

class PizzaRepositoryImpl implements PizzaRepository {
  final PizzaProvider _pizzaProvider;

  const PizzaRepositoryImpl(this._pizzaProvider);

  @override
  Future<List<Pizza>> getPizzas() async {
    return await _pizzaProvider.getPizzas();
  }
}
