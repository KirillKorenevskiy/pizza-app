import '../../../domain.dart';
import '../use_case.dart';

class GetUserOrdersUseCase implements FutureUseCase<String, List<Order>> {
  final OrdersRepository _ordersRepository;

  const GetUserOrdersUseCase(this._ordersRepository);

  @override
  Future<List<Order>> execute(String input) async {
    final List<Order> orders = await _ordersRepository.getUserOrders(input);

    return orders;
  }
}
