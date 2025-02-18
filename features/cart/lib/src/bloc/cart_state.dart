part of 'cart_cubit.dart';

class CartState {
  final bool isLoading;
  final List<CartItem> cartItems;
  final int? newQuantity;
  final String? errorMessage;

  const CartState({
    this.isLoading = false,
    this.cartItems = const <CartItem>[],
    this.newQuantity,
    this.errorMessage,
  });

  CartState copyWith({
    bool? isLoading,
    List<CartItem>? cartItems,
    int? newQuantity,
    String? errorMessage,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cartItems: cartItems ?? this.cartItems,
      newQuantity: newQuantity ?? this.newQuantity,
      errorMessage: errorMessage,
    );
  }
}
