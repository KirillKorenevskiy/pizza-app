part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

class SignInData extends SignInState {
  final bool obscurePassword;
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;

  SignInData({
    required this.obscurePassword,
    required this.isLoading,
    this.successMessage,
    this.errorMessage,
  });

  SignInData copyWith({
    bool? obscurePassword,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return SignInData(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }
}
