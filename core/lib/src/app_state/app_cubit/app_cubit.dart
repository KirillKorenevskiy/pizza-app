import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../../enums/auth.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final ListenUserUseCase _listenUserUseCase;
  final AppRouter _appRouter;
  late final StreamSubscription<MyUser?> _userSubscription;

  AppCubit(
    this._listenUserUseCase,
    this._appRouter,
  ) : super(const AppState.unknown()) {
    _userSubscription = _listenUserUseCase.execute().listen((MyUser? user) {
      if (user != null && user != MyUser.empty) {
        emit(AppState.authenticated(user));
      } else {
        emit(const AppState.unauthenticated());
      }
    });
  }

  void goToWelcomeScreen() {
    _appRouter.push(const WelcomeScreen());
  }

  void goToPizzasScreen() {
    _appRouter.push(const PizzasScreen());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
