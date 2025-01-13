import 'package:domain/domain.dart';

import '../../data.dart';
import '../entities/requests/sign_in_request.dart';
import '../entities/requests/sign_up_request.dart';
import '../providers/remote_user_provider.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteUserProvider _userProvider;

  const UserRepositoryImpl(this._userProvider);

  @override
  Stream<MyUser?> get user async* {
    await for (final userEntity in _userProvider.user) {
      yield userEntity != null ? UserMapper.fromEntity(userEntity) : null;
    }
  }

  @override
  Future<void> signIn(SignInPayload payload) async {
    final SignInRequest request = SignInRequest(
      email: payload.email,
      password: payload.password,
    );
    await _userProvider.signIn(request);
  }

  @override
  Future<MyUser> signUp(SignUpPayload payload) async {
    final SignUpRequest request = SignUpRequest(
      myUser: UserMapper.toEntity(payload.myUser),
      password: payload.password,
    );
    final UserEntity newUserEntity = await _userProvider.signUp(request);

    return UserMapper.fromEntity(newUserEntity);
  }

  @override
  Future<void> logOut() async {
    await _userProvider.logOut();
  }

  @override
  Future<void> setUserData(MyUser user) async {
    await _userProvider.setUserData(UserMapper.toEntity(user));
  }
}
