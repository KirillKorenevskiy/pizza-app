import '../../domain.dart';

abstract class PizzaRepository {
  Future<List<Pizza>> getPizzas();
}
