import 'package:domain/domain.dart';
import '../../data.dart';
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
    await _userProvider.signIn(payload.email, payload.password);
  }

  @override
  Future<MyUser> signUp(SignUpPayload payload) async {
    final UserEntity userEntity = UserMapper.toEntity(payload.myUser);
    final UserEntity newUserEntity = await _userProvider.signUp(userEntity, payload.password);

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
