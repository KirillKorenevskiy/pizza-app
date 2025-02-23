part of 'details_cubit.dart';

class DetailsState {
  final List<Ingredient> ingredients;
  final int size;
  final List<String?> selectedIngredients;
  final bool isInCart;
  final String? errorMessage;

  DetailsState({
    this.ingredients = const <Ingredient>[],
    this.size = 25,
    this.selectedIngredients = const <String>[],
    this.isInCart = false,
    this.errorMessage,
  });

  DetailsState copyWith({
    List<Ingredient>? ingredients,
    int? size,
    List<String>? selectedIngredients,
    bool? isInCart,
    String? errorMessage,
  }) {
    return DetailsState(
      ingredients: ingredients ?? this.ingredients,
      size: size ?? this.size,
      selectedIngredients: selectedIngredients ?? this.selectedIngredients,
      isInCart: isInCart ?? this.isInCart,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
