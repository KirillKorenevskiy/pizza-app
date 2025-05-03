import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase _signInUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  SignInCubit(
    this._signInUseCase,
    this._signInWithGoogleUseCase,
  ) : super(
          const SignInState(
            obscurePassword: true,
            isLoading: false,
          ),
        );

  Future<void> signIn(String email, String password) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    try {
      await _signInUseCase.execute(
        SignInPayload(
          email: email,
          password: password,
        ),
      );
      emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'success',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'нет такого пользователя',
        ),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );

      await _signInWithGoogleUseCase.execute();

      emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'success',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );

      log(e.toString());
    }
  }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
      ),
    );
  }
}
