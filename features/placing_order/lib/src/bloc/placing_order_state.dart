part of 'placing_order_cubit.dart';

class PlacingOrderState {
  final String selectedDeliveryTime;
  final String selectedPaymentMethod;

  PlacingOrderState({
    this.selectedDeliveryTime = '',
    this.selectedPaymentMethod = '',
  });

  PlacingOrderState copyWith({
    String? selectedDeliveryTime,
    String? selectedPaymentMethod,
  }) {
    return PlacingOrderState(
      selectedDeliveryTime: selectedDeliveryTime ?? this.selectedDeliveryTime,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }
}
