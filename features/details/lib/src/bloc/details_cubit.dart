import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final GetIngredientsUseCase _getIngredientsUseCase;
  final GetDetailByIdUseCase _getDetailByIdUseCase;
  final UpdateDetailsUseCase _updateDetailsUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final AddDetailsUseCase _addDetailsUseCase;
  final CheckCartUseCase _checkCartUseCase;
  final GetPizzaByIdUseCase _getPizzaByIdUseCase;
  final ListenUserUseCase _listenUserUseCase;
  final AppRouter _appRouter;

  DetailsCubit(
    this._getIngredientsUseCase,
    this._getDetailByIdUseCase,
    this._updateDetailsUseCase,
    this._addToCartUseCase,
    this._addDetailsUseCase,
    this._checkCartUseCase,
    this._getPizzaByIdUseCase,
    this._listenUserUseCase,
    this._appRouter,
  ) : super(DetailsState()) {
    getIngredients();
  }

  Future<void> getPizza(String id) async {
    final Pizza pizza = await _getPizzaByIdUseCase.execute(id);

    emit(
      state.copyWith(
        pizza: pizza,
      ),
    );
  }

  Future<void> getIngredients() async {
    try {
      final List<Ingredient> ingredients =
          await _getIngredientsUseCase.execute();

      emit(
        state.copyWith(
          ingredients: ingredients,
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

  String? _convertIngredientsToString(List<String?> ingredients) {
    if (ingredients.isEmpty) {
      return null;
    }

    return ingredients.map((String? ingredient) => ingredient).join(', ');
  }

  List<String>? _convertStringToIngredients(String? ingredientsString) {
    final List<String>? ingredientNames = ingredientsString
        ?.split(',')
        .map((String name) => name.trim())
        .toList();

    return ingredientNames;
  }

  Future<void> addToCart(
    String pizzaId,
    int size,
    List<String?> ingredients,
  ) async {
    try {
      final String userId = await _getUserId();

      final String? ingredientsString =
          _convertIngredientsToString(ingredients);

      await _addDetailsUseCase.execute(
        DetailPayload(
          id: pizzaId,
          userId: userId,
          size: size,
          ingredients: ingredientsString,
        ),
      );

      await _addToCartUseCase.execute(
        CartPayload(
          pizzaId: pizzaId,
          userId: userId,
        ),
      );

      await _appRouter.replace(const CartScreen());
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
        ),
      );

      log(e.toString());
    }
  }

  Future<void> getDetails(String pizzaId) async {
    try {
      final String userId = await _getUserId();

      final Details? detail = await _getDetailByIdUseCase.execute(
        GetDeleteDetailPayload(
          id: pizzaId,
          userId: userId,
        ),
      );
      final bool isInCart = await _checkCartUseCase.execute(
        CartPayload(
          pizzaId: pizzaId,
          userId: userId,
        ),
      );

      if (detail != null) {
        final List<String>? selectedIngredients =
            _convertStringToIngredients(detail.ingredients);

        emit(
          state.copyWith(
            size: detail.size,
            selectedIngredients: selectedIngredients,
            isInCart: isInCart,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateDetails(
    String id,
    int size,
    List<String?> ingredients,
  ) async {
    final String? ingredientsString = _convertIngredientsToString(ingredients);

    try {
      await _updateDetailsUseCase.execute(
        DetailPayload(
          id: id,
          userId: await _getUserId(),
          size: size,
          ingredients: ingredientsString,
        ),
      );

      await _appRouter.maybePop();
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void toggleIngredient(Ingredient ingredient) {
    final List<String> updatedIngredients =
        List<String>.from(state.selectedIngredients);

    if (updatedIngredients.contains(ingredient.name)) {
      updatedIngredients.remove(ingredient.name);
    } else {
      updatedIngredients.add(ingredient.name);
    }

    emit(
      state.copyWith(
        selectedIngredients: updatedIngredients,
      ),
    );
  }

  void goBack() {
    _appRouter.maybePop();
  }

  Future<String> _getUserId() async {
    final MyUser? currentUser = await _listenUserUseCase.execute().first;
    final String userId = currentUser!.userId;

    return userId;
  }
}
