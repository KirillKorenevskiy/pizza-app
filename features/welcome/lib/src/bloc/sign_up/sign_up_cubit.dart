import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit(
    this._signUpUseCase,
  ) : super(
          SignUpData(
            obscurePassword: true,
            isLoading: false,
            containsUpperCase: false,
            containsLowerCase: false,
            containsNumber: false,
            containsSpecialChar: false,
            contains8Length: false,
          ),
        );

  Future<void> signUp(String email, String name, String password) async {
    emit(
      (state as SignUpData).copyWith(
        isLoading: true,
      ),
    );
    final MyUser user =
        MyUser(userId: '', email: email, name: name, hasActiveCart: false);
    try {
      await _signUpUseCase
          .execute(SignUpPayload(myUser: user, password: password));
      emit(
        (state as SignUpData).copyWith(
          isLoading: false,
          successMessage: 'success',
        ),
      );
    } catch (e) {
      emit(
        (state as SignUpData).copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void togglePasswordVisibility() {
    final SignUpData currentState = state as SignUpData;
    emit(
      currentState.copyWith(obscurePassword: !currentState.obscurePassword),
    );
  }

  void updatePasswordValidation(String password) {
    final SignUpData currentState = state as SignUpData;
    emit(
      currentState.copyWith(
        containsUpperCase: password.contains(RegExp(r'[A-Z]')),
        containsLowerCase: password.contains(RegExp(r'[a-z]')),
        containsNumber: password.contains(RegExp(r'[0-9]')),
        containsSpecialChar: password
            .contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])')),
        contains8Length: password.length >= 8,
      ),
    );
  }
}
