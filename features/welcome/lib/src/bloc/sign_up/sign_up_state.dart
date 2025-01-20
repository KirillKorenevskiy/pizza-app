part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

class SignUpData extends SignUpState {
  final bool obscurePassword;
  final bool isLoading;
  final bool containsUpperCase;
  final bool containsLowerCase;
  final bool containsNumber;
  final bool containsSpecialChar;
  final bool contains8Length;
  final String? successMessage;
  final String? errorMessage;

  SignUpData({
    required this.obscurePassword,
    required this.isLoading,
    required this.containsUpperCase,
    required this.containsLowerCase,
    required this.containsNumber,
    required this.containsSpecialChar,
    required this.contains8Length,
    this.successMessage,
    this.errorMessage,
  });

  SignUpData copyWith({
    bool? obscurePassword,
    bool? isLoading,
    bool? containsUpperCase,
    bool? containsLowerCase,
    bool? containsNumber,
    bool? containsSpecialChar,
    bool? contains8Length,
    String? successMessage,
    String? errorMessage,
  }) {
    return SignUpData(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      errorMessage: errorMessage,
      containsUpperCase: containsUpperCase ?? this.containsUpperCase,
      containsLowerCase: containsLowerCase ?? this.containsLowerCase,
      containsNumber: containsNumber ?? this.containsNumber,
      containsSpecialChar: containsSpecialChar ?? this.containsSpecialChar,
      contains8Length: contains8Length ?? this.contains8Length,
    );
  }
}
