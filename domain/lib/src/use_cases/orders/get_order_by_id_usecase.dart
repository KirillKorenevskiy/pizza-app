import '../../../domain.dart';
import '../use_case.dart';

class GetOrderByIdUseCase implements FutureUseCase<String, Order?> {
  final OrdersRepository _ordersRepository;

  const GetOrderByIdUseCase(this._ordersRepository);

  @override
  Future<Order?> execute(String input) async {
    final Order? order = await _ordersRepository.getOrderById(input);
    return order;
  }
}
