part of 'adminka_cubit.dart';

class AdminkaState {
  final List<Pizza> pizzas;
  final bool loading;
  final String? error;

  AdminkaState({
    this.pizzas = const <Pizza>[],
    this.loading = false,
    this.error,
  });

  AdminkaState copyWith({
    List<Pizza>? pizzas,
    bool? loading,
    String? error,
  }) {
    return AdminkaState(
      pizzas: pizzas ?? this.pizzas,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
