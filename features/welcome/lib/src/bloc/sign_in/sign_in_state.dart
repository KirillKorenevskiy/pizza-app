part of 'sign_in_cubit.dart';

@immutable
class SignInState {
  final bool obscurePassword;
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;

  const SignInState({
    required this.obscurePassword,
    required this.isLoading,
    this.successMessage,
    this.errorMessage,
  });

  SignInState copyWith({
    bool? obscurePassword,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return SignInState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }
}
