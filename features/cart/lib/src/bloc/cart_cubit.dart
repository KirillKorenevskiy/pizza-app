import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartsUseCase _getCartsUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final UpdateQuantityUseCase _updateQuantityUseCase;
  final AppRouter _appRouter;

  CartCubit(
    this._getCartsUseCase,
    this._removeFromCartUseCase,
    this._updateQuantityUseCase,
    this._appRouter,
  ) : super(const CartState()) {
    getCart();
  }

  Future<void> getCart() async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    try {
      final List<CartItem> cartItems = await _getCartsUseCase.execute();

      emit(
        state.copyWith(
          isLoading: false,
          cartItems: cartItems,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error in getCart: $e',
        ),
      );
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      await _removeFromCartUseCase.execute(
        id,
      );
      await getCart();
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateQuantity(int index, int newQuantity) async {
    final List<CartItem> updatedCart = List<CartItem>.from(state.cartItems);

    final CartItem updatedItem = updatedCart[index].copyWith(
      quantity: newQuantity,
    );

    await _updateQuantityUseCase.execute(
      UpdateQuantityPayload(
        cartId: updatedItem.pizza.pizzaId,
        quantity: newQuantity,
      ),
    );

    updatedCart[index] = updatedItem;

    emit(
      state.copyWith(
        cartItems: updatedCart,
      ),
    );
  }

  void closeCart() {
    _appRouter.maybePop();
  }
}
