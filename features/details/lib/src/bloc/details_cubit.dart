import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final GetIngredientsUseCase _getIngredientsUseCase;

  DetailsCubit(
    this._getIngredientsUseCase,
  ) : super(DetailsState());

  Future<void> getIngredients() async {
    try {
      final List<Ingredient> ingredients =
          await _getIngredientsUseCase.execute();

      emit(
        state.copyWith(ingredients: ingredients),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
