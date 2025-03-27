part of 'placing_order_cubit.dart';

class PlacingOrderState {
  final bool isLoading;
  final String selectedDeliveryTime;
  final String selectedPaymentMethod;
  final String? errorMessage;
  final List<String> cartItems;

  PlacingOrderState({
    this.isLoading = false,
    this.selectedDeliveryTime = '',
    this.selectedPaymentMethod = '',
    this.errorMessage,
    this.cartItems = const <String>[],
  });

  PlacingOrderState copyWith({
    bool? isLoading,
    String? selectedDeliveryTime,
    String? selectedPaymentMethod,
    String? errorMessage,
    List<String>? cartItems,
  }) {
    return PlacingOrderState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDeliveryTime: selectedDeliveryTime ?? this.selectedDeliveryTime,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
