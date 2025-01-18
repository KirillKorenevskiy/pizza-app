import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase _signInUseCase;
  final LogOutUseCase _logOutUseCase;
  bool _obscurePassword = true;

  SignInCubit(
    this._signInUseCase,
    this._logOutUseCase,
  ) : super(SignInInitial());

  Future<void> signIn(String email, String password) async {
    emit(SignInProcess());
    try {
      await _signInUseCase
          .execute(SignInPayload(email: email, password: password));
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _logOutUseCase.execute();
  }

  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    emit(SignInPasswordVisibilityChanged(_obscurePassword));
  }
}
