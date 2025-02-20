part of 'details_cubit.dart';

class DetailsState {
  final List<Ingredient> ingredients;
  final String? errorMessage;

  DetailsState({
    this.ingredients = const <Ingredient>[],
    this.errorMessage,
  });

  DetailsState copyWith({
    List<Ingredient>? ingredients,
    String? errorMessage,
  }) {
    return DetailsState(
      ingredients: ingredients ?? this.ingredients,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
