part of 'app_cubit.dart';

class AppState {
  const AppState._({
    this.status = AppStatus.unknown,
    this.user,
  });

  final AppStatus status;
  final MyUser? user;

  const AppState.unknown() : this._();

  const AppState.authenticated(MyUser myUser)
      : this._(status: AppStatus.authenticated, user: myUser);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
}
