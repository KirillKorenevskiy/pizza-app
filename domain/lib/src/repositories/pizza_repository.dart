import '../../domain.dart';

abstract class PizzaRepository {
  Future<List<Pizza>> getPizzas();

  Future<Pizza> getPizzaById(String id);
}
