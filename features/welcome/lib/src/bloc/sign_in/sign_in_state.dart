part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInProcess extends SignInState {}

final class SignInSuccess extends SignInState {}

final class SignInError extends SignInState {
  late final String message;

  SignInError(this.message);
}

class SignInPasswordVisibilityChanged extends SignInState {
  final bool obscurePassword;

  SignInPasswordVisibilityChanged(this.obscurePassword);
}
