import 'package:domain/domain.dart';

import '../../data.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final RemoteOrdersProvider _remoteOrdersProvider;

  const OrdersRepositoryImpl(this._remoteOrdersProvider);

  @override
  Future<void> addOrder(Order order) async {
    await _remoteOrdersProvider.addOrder(
      OrderMapper.toEntity(order),
    );
  }

  @override
  Future<Order?> getOrderById(String id) async {
    final OrderEntity? orderEntity =
        await _remoteOrdersProvider.getOrderById(id);
    if (orderEntity == null) return null;

    return OrderMapper.fromEntity(orderEntity);
  }

  @override
  Future<List<Order>> getUserOrders(String userId) async {
    final List<OrderEntity> orderEntities =
        await _remoteOrdersProvider.getUserOrders(userId);

    return orderEntities.map(OrderMapper.fromEntity).toList();
  }
}
