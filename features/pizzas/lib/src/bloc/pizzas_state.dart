part of 'pizzas_cubit.dart';

@immutable
class PizzasState {
  final List<Pizza> pizzas;
  final Set<String> cartItems;
  final bool isLoading;
  final String? errorMessage;

  const PizzasState({
    this.pizzas = const <Pizza>[],
    this.cartItems = const <String>{},
    this.isLoading = false,
    this.errorMessage,
  });

  PizzasState copyWith({
    List<Pizza>? pizzas,
    Set<String>? cartItems,
    bool? isLoading,
    bool? isInCart,
    String? errorMessage,
  }) {
    return PizzasState(
      pizzas: pizzas ?? this.pizzas,
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

