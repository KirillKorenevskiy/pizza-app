part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  late final String message;
  late final StackTrace stackTrace;

  SignUpError(this.message, this.stackTrace);
}

class SignUpProcess extends SignUpState {}

class SignUpPasswordVisibilityChanged extends SignUpState {
  final bool obscurePassword;

  SignUpPasswordVisibilityChanged(this.obscurePassword);
}
