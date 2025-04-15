import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartsUseCase _getCartsUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final UpdateQuantityUseCase _updateQuantityUseCase;
  final DeleteDetailsUseCase _deleteDetailsUseCase;
  final GetDetailsUseCase _getDetailsUseCase;
  final AppRouter _appRouter;
  final ListenUserUseCase _listenUserUseCase;

  CartCubit(
    this._getCartsUseCase,
    this._removeFromCartUseCase,
    this._updateQuantityUseCase,
    this._deleteDetailsUseCase,
    this._getDetailsUseCase,
    this._listenUserUseCase,
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
      final String userId = await _getUserId();
      final List<CartItem> cartItems = await _getCartsUseCase.execute(
        userId,
      );

      final List<Details> detailsItems =
          await _getDetailsUseCase.execute(userId);

      emit(
        state.copyWith(
          isLoading: false,
          cartItems: cartItems,
          detailsItems: detailsItems,
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

  Future<void> removeFromCart(String pizzaId) async {
    try {
      final String userId = await _getUserId();

      await _removeFromCartUseCase.execute(
        CartPayload(
          pizzaId: pizzaId,
          userId: userId,
        ),
      );
      await _deleteDetailsUseCase.execute(
        GetDeleteDetailPayload(
          id: pizzaId,
          userId: userId,
        ),
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

    final String userId = await _getUserId();

    await _updateQuantityUseCase.execute(
      UpdateQuantityPayload(
        cartId: updatedItem.pizza.pizzaId,
        quantity: newQuantity,
        userId: userId,
      ),
    );

    updatedCart[index] = updatedItem;

    emit(
      state.copyWith(
        cartItems: updatedCart,
      ),
    );
  }

  Future<String> _getUserId() async {
    final MyUser? currentUser = await _listenUserUseCase.execute().first;
    final String userId = currentUser!.userId;

    return userId;
  }

  Future<void> goToDetails(String pizzaId) async {
    await _appRouter.push(
      DetailsScreen(id: pizzaId),
    );
    await getCart();
  }

  void goToMap() {
    _appRouter.push(
      MapScreen(isEditingMode: false),
    );
  }

  void closeCart() {
    _appRouter.maybePop();
  }
}
