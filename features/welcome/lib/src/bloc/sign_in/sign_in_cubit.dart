import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase _signInUseCase;

  SignInCubit(
    this._signInUseCase,
  ) : super(
          SignInData(
            obscurePassword: true,
            isLoading: false,
          ),
        );

  Future<void> signIn(String email, String password) async {
    emit(SignInData(
      obscurePassword: true,
      isLoading: true,
    ));

    try {
      await _signInUseCase.execute(
        SignInPayload(email: email, password: password),
      );
      emit(
        (state as SignInData).copyWith(
          isLoading: false,
          successMessage: 'success',
        ),
      );
    } catch (e) {
      emit(
        (state as SignInData).copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void togglePasswordVisibility() {
    final SignInData currentState = state as SignInData;
    emit(
      currentState.copyWith(obscurePassword: !currentState.obscurePassword),
    );
  }
}
