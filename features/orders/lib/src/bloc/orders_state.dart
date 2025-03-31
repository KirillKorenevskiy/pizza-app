part of 'orders_cubit.dart';

class OrdersState {
  final List<Order> orders;
  final String? errorMessage;

  OrdersState({
    this.orders = const <Order>[],
    this.errorMessage,
  });

  OrdersState copyWith({
    List<Order>? orders,
    String? errorMessage,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
