import '../../../domain.dart';
import '../use_case.dart';

class LogOutUseCase implements FutureUseCase<void, void> {
  final UserRepository _userRepository;

  const LogOutUseCase(this._userRepository);

  @override
  Future<void> execute([void input]) {
    return _userRepository.logOut();
  }
}
