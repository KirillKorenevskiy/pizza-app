part of 'app_cubit.dart';

class AppState {
  final AppStatus status;
  final MyUser? user;
  final LocalizationLanguages language;
  final double cartPrice;
  final String? errorMessage;

  const AppState._({
    this.status = AppStatus.unknown,
    this.user,
    this.language = LocalizationLanguages.english,
    this.cartPrice = 0,
    this.errorMessage,
  });

  const AppState.unknown() : this._();

  const AppState.authenticated(
    MyUser myUser,
    LocalizationLanguages language,
  ) : this._(
          status: AppStatus.authenticated,
          user: myUser,
          language: language,
        );

  const AppState.unauthenticated(LocalizationLanguages language)
      : this._(
          status: AppStatus.unauthenticated,
          language: language,
        );

  AppState copyWith({
    AppStatus? status,
    MyUser? user,
    LocalizationLanguages? language,
    double? cartPrice,
    String? errorMessage,
  }) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
      language: language ?? this.language,
      cartPrice: cartPrice ?? this.cartPrice,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
