import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';
import 'package:navigation/navigation.dart';

part 'pizzas_state.dart';

class PizzasCubit extends Cubit<PizzasState> {
  final GetPizzasUseCase _getPizzasUseCase;
  final LogOutUseCase _logOutUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final CheckCartUseCase _checkCartUseCase;
  final ListenCartUseCase _listenCartUseCase;
  final DeleteDetailsUseCase _deleteDetailsUseCase;
  final AddDetailsUseCase _addDetailsUseCase;
  final AppRouter _appRouter;

  late StreamSubscription<List<CartItem>> _cartSubscription;

  PizzasCubit(
    this._getPizzasUseCase,
    this._logOutUseCase,
    this._addToCartUseCase,
    this._removeFromCartUseCase,
    this._checkCartUseCase,
    this._listenCartUseCase,
    this._deleteDetailsUseCase,
    this._addDetailsUseCase,
    this._appRouter,
  ) : super(const PizzasState()) {
    _init();
  }

  Future<void> _init() async {
    await getPizzas();
    _cartSubscription = _listenCartUseCase.execute().listen(
      (List<CartItem> cartItems) {
        final Set<String> updatedCartItems =
            cartItems.map((CartItem item) => item.pizza.pizzaId).toSet();
        emit(
          state.copyWith(
            cartItems: updatedCartItems,
          ),
        );
      },
    );
  }

  Future<void> getPizzas() async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    try {
      final List<Pizza> pizzas = await _getPizzasUseCase.execute();
      final Set<String> cartItems = <String>{};

      for (final Pizza pizza in pizzas) {
        final bool isInCart = await _checkCartUseCase.execute(
          pizza.pizzaId,
        );

        if (isInCart) {
          cartItems.add(pizza.pizzaId);
        }
      }

      emit(
        state.copyWith(
          pizzas: pizzas,
          cartItems: cartItems,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  Future<void> toggleCart(String pizzaId) async {
    try {
      final Set<String> updatedCart = Set<String>.from(state.cartItems);

      if (updatedCart.contains(pizzaId)) {
        await _removeFromCartUseCase.execute(
          pizzaId,
        );
        await _deleteDetailsUseCase.execute(
          pizzaId,
        );
        updatedCart.remove(pizzaId);
      } else {
        await _addToCartUseCase.execute(
          pizzaId,
        );
        await _addDetailsUseCase.execute(
          DetailPayload(
            id: pizzaId,
            size: 25,
            ingredients: null,
          ),
        );
        updatedCart.add(pizzaId);
      }

      emit(
        state.copyWith(
          cartItems: updatedCart,
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

  void goToCart() {
    _appRouter.push(const CartScreen());
  }

  void goToDetails(String pizzaId) {
    _appRouter.push(
      DetailsScreen(
        id: pizzaId,
      ),
    );
  }

  Future<void> logOut() async {
    await _logOutUseCase.execute();
  }

  @override
  Future<void> close() {
    _cartSubscription.cancel();
    return super.close();
  }
}
