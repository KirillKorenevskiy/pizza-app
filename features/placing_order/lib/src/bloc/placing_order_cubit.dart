import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'placing_order_state.dart';

class PlacingOrderCubit extends Cubit<PlacingOrderState> {
  final AppRouter _appRouter;

  PlacingOrderCubit(
    this._appRouter,
  ) : super(PlacingOrderState());

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
}
