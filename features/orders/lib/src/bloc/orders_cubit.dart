import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetUserOrdersUseCase _getUserOrdersUseCase;
  final AppRouter _appRouter;

  OrdersCubit(
    this._getUserOrdersUseCase,
    this._appRouter,
  ) : super(OrdersState());

  void goBack() {
    _appRouter.maybePop();
  }

  Future<void> getOrders(String id) async {
    try {
      final List<Order> orders = await _getUserOrdersUseCase.execute(id);

      emit(
        state.copyWith(
          orders: orders,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
