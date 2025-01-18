import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  bool _obscurePassword = true;

  SignUpCubit(
    this._signUpUseCase,
  ) : super(SignUpInitial());

  Future<void> signUp(MyUser user, String password) async {
    emit(SignUpProcess());
    try {
      await _signUpUseCase
          .execute(SignUpPayload(myUser: user, password: password));
      emit(SignUpSuccess());
    } catch (e, stackTrace) {
      emit(SignUpError(e.toString(), stackTrace));
    }
  }

  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    emit(SignUpPasswordVisibilityChanged(_obscurePassword));
  }
}
