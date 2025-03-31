import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../../enums/auth.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final ListenUserUseCase _listenUserUseCase;
  final GetLanguageUseCase _getLanguageUseCase;
  final ChangeLanguageUseCase _changeLanguageUseCase;
  final AppRouter _appRouter;
  late final StreamSubscription<MyUser?> _userSubscription;

  AppCubit(
    this._listenUserUseCase,
    this._getLanguageUseCase,
    this._changeLanguageUseCase,
    this._appRouter,
  ) : super(const AppState.unknown()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final LocalizationLanguages? language =
          await _getLanguageUseCase.execute();
      final LocalizationLanguages selectedLanguage =
          language ?? LocalizationLanguages.english;

      _userSubscription = _listenUserUseCase.execute().listen(
        (MyUser? user) {
          if (user != null && user != MyUser.empty) {
            emit(
              AppState.authenticated(
                user,
                selectedLanguage,
              ),
            );
            if (_appRouter.current.name != DetailsScreen.name) {
              _appRouter.replace(const PizzasScreen());
            }
          } else {
            emit(
              AppState.unauthenticated(selectedLanguage),
            );
            if (_appRouter.current.name != WelcomeScreen.name) {
              _appRouter.replace(const WelcomeScreen());
            }
          }
        },
      );
    } catch (error) {
      emit(
        state.copyWith(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> changeLanguage() async {
    try {
      final LocalizationLanguages newLanguage = switch (state.language) {
        LocalizationLanguages.english => LocalizationLanguages.russian,
        LocalizationLanguages.russian => LocalizationLanguages.english,
      };

      await _changeLanguageUseCase.execute(
        newLanguage,
      );
      emit(
        state.copyWith(
          language: newLanguage,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void updateCartPrice(double price) {
    emit(
      state.copyWith(
        cartPrice: price,
      ),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
