part of 'details_cubit.dart';

class DetailsState {
  final Pizza pizza;
  final List<Ingredient> ingredients;
  final int size;
  final List<String?> selectedIngredients;
  final bool isInCart;
  final String? errorMessage;

  DetailsState({
    this.pizza = Pizza.empty,
    this.ingredients = const <Ingredient>[],
    this.size = 25,
    this.selectedIngredients = const <String>[],
    this.isInCart = false,
    this.errorMessage,
  });

  DetailsState copyWith({
    Pizza? pizza,
    List<Ingredient>? ingredients,
    int? size,
    List<String>? selectedIngredients,
    bool? isInCart,
    String? errorMessage,
  }) {
    return DetailsState(
      pizza: pizza ?? this.pizza,
      ingredients: ingredients ?? this.ingredients,
      size: size ?? this.size,
      selectedIngredients: selectedIngredients ?? this.selectedIngredients,
      isInCart: isInCart ?? this.isInCart,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
