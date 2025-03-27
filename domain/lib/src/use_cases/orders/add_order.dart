import '../../../domain.dart';
import '../use_case.dart';

class AddOrderUseCase implements FutureUseCase<Order, void> {
  final OrdersRepository _ordersRepository;

  const AddOrderUseCase(this._ordersRepository);

  @override
  Future<void> execute(Order input) {
    return _ordersRepository.addOrder(input);
  }
}
