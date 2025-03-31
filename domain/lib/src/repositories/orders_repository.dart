import '../../domain.dart';

abstract interface class OrdersRepository {
  Future<List<Order>> getUserOrders(String userId);

  Future<void> addOrder(Order order);

  Future<Order?> getOrderById(String id);
}
