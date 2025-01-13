import 'package:domain/domain.dart';

import '../../data.dart';
import '../providers/remote_pizza_provider.dart';

class PizzaRepositoryImpl implements PizzaRepository {
  final RemotePizzaProvider _pizzaProvider;

  const PizzaRepositoryImpl(this._pizzaProvider);

  @override
  Future<List<Pizza>> getPizzas() async {
    final List<PizzaEntity> pizzaEntities = await _pizzaProvider.getPizzas();

    return pizzaEntities.map(PizzaMapper.fromEntity).toList();
  }
}
