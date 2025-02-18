import 'package:domain/domain.dart';

import '../../data.dart';

class PizzaRepositoryImpl implements PizzaRepository {
  final RemotePizzaProvider _pizzaProvider;

  const PizzaRepositoryImpl(this._pizzaProvider);

  @override
  Future<List<Pizza>> getPizzas() async {
    final List<PizzaEntity> pizzaEntities = await _pizzaProvider.getPizzas();

    return pizzaEntities.map(PizzaMapper.fromEntity).toList();
  }

  @override
  Future<Pizza> getPizzaById(String id) async {
    final PizzaEntity entity = await _pizzaProvider.getPizzaById(id);

    return PizzaMapper.fromEntity(entity);
  }
}
