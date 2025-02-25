part of 'cart_cubit.dart';

class CartState {
  final bool isLoading;
  final List<CartItem> cartItems;
  final int? newQuantity;
  final List<Details> detailsItems;
  final String? errorMessage;

  const CartState({
    this.isLoading = false,
    this.cartItems = const <CartItem>[],
    this.newQuantity,
    this.detailsItems = const <Details>[],
    this.errorMessage,
  });

  CartState copyWith({
    bool? isLoading,
    List<CartItem>? cartItems,
    int? newQuantity,
    List<Details>? detailsItems,
    String? errorMessage,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cartItems: cartItems ?? this.cartItems,
      newQuantity: newQuantity ?? this.newQuantity,
      detailsItems: detailsItems ?? this.detailsItems,
      errorMessage: errorMessage,
    );
  }

  double get totalPrice => double.parse(
        cartItems
            .fold(
              0.0,
              (double sum, CartItem item) => sum + item.totalPrice,
            )
            .toStringAsFixed(2),
      );

  int get totalQuantity => cartItems.fold(
        0,
        (int sum, CartItem item) => sum + item.quantity,
      );
}
