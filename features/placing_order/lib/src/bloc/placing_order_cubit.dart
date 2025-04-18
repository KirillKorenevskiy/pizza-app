import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'placing_order_state.dart';

class PlacingOrderCubit extends Cubit<PlacingOrderState> {
  final AddOrderUseCase _addOrderUseCase;
  final GetCartsUseCase _getCartsUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final ClearDetailsUseCase _clearDetailsUseCase;
  final ListenUserUseCase _listenUserUseCase;
  final AppRouter _appRouter;

  PlacingOrderCubit(
    this._addOrderUseCase,
    this._getCartsUseCase,
    this._clearCartUseCase,
    this._clearDetailsUseCase,
    this._listenUserUseCase,
    this._appRouter,
  ) : super(PlacingOrderState()) {
    getCartItems();
  }

  Future<void> addOrder(Order order) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final String userId = await _getUserId();

    try {
      await _addOrderUseCase.execute(
        order,
      );
      await _clearDetailsUseCase.execute(
        userId,
      );
      await _clearCartUseCase.execute(
        userId,
      );

      await _appRouter.replace(const PizzasScreen());
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> getCartItems() async {
    final String userId = await _getUserId();

    final List<CartItem> cartItems = await _getCartsUseCase.execute(
      userId,
    );

    final List<String> pizzasNames =
        cartItems.map((CartItem item) => item.pizza.name).toList();

    emit(
      state.copyWith(
        cartItems: pizzasNames,
      ),
    );
  }

  void selectDeliveryTime(String time) {
    emit(
      state.copyWith(
        selectedDeliveryTime: time,
      ),
    );
  }

  void selectPaymentMethod(PaymentMethod method) {
    emit(
      state.copyWith(
        selectedPaymentMethod: method.label,
      ),
    );
  }

  void goToMap(Address address) {
    _appRouter.replace(
      MapScreen(
        isEditingMode: true,
        address: address,
      ),
    );
  }

  Future<String> _getUserId() async {
    final MyUser? currentUser = await _listenUserUseCase.execute().first;
    final String userId = currentUser!.userId;

    return userId;
  }
}
