import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit(
    this._signUpUseCase,
  ) : super(
          const SignUpState(
            obscurePassword: true,
            isLoading: false,
            containsUpperCase: false,
            containsLowerCase: false,
            containsNumber: false,
            containsSpecialChar: false,
            containsMinLength: false,
          ),
        );

  Future<void> signUp(String email, String name, String password) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final MyUser user = MyUser(
      userId: '',
      email: email,
      name: name,
      hasActiveCart: false,
    );
    try {
      await _signUpUseCase.execute(
        SignUpPayload(
          myUser: user,
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
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
      ),
    );
  }

  void updatePasswordValidation(String password) {
    emit(
      state.copyWith(
        containsUpperCase: password.contains(RegExp('[A-Z]')),
        containsLowerCase: password.contains(RegExp('[a-z]')),
        containsNumber: password.contains(RegExp('[0-9]')),
        containsSpecialChar: password
            .contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])')),
        containsMinLength: password.length >= 8,
      ),
    );
  }
}
