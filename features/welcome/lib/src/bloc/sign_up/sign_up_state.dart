part of 'sign_up_cubit.dart';

@immutable
class SignUpState {
  final bool obscurePassword;
  final bool isLoading;
  final bool containsUpperCase;
  final bool containsLowerCase;
  final bool containsNumber;
  final bool containsSpecialChar;
  final bool containsMinLength;
  final String? successMessage;
  final String? errorMessage;

  const SignUpState({
    required this.obscurePassword,
    required this.isLoading,
    required this.containsUpperCase,
    required this.containsLowerCase,
    required this.containsNumber,
    required this.containsSpecialChar,
    required this.containsMinLength,
    this.successMessage,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? obscurePassword,
    bool? isLoading,
    bool? containsUpperCase,
    bool? containsLowerCase,
    bool? containsNumber,
    bool? containsSpecialChar,
    bool? containsMinLength,
    String? successMessage,
    String? errorMessage,
  }) {
    return SignUpState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      errorMessage: errorMessage,
      containsUpperCase: containsUpperCase ?? this.containsUpperCase,
      containsLowerCase: containsLowerCase ?? this.containsLowerCase,
      containsNumber: containsNumber ?? this.containsNumber,
      containsSpecialChar: containsSpecialChar ?? this.containsSpecialChar,
      containsMinLength: containsMinLength ?? this.containsMinLength,
    );
  }
}
