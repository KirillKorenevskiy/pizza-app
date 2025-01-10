import 'package:domain/domain.dart';
import '../providers/user_provider.dart';

class UserRepositoryImpl implements UserRepository {
  final MyUserProvider _userProvider;

  const UserRepositoryImpl(this._userProvider);

  @override
  Stream<MyUser?> get user {
    return _userProvider.user;
  }

  @override
  Future<void> signIn(String email, String password) async {
      await _userProvider.signIn(email, password);
  }

  @override
  Future<MyUser> signUp(MyUser user, String password) async {
    final MyUser newUser = await _userProvider.signUp(user, password);
    await _userProvider.setUserData(newUser);
    return newUser;
  }

  @override
  Future<void> logOut() async {
    await _userProvider.logOut();
  }

  @override
  Future<void> setUserData(MyUser user) async {
    await _userProvider.setUserData(user);
  }
}
