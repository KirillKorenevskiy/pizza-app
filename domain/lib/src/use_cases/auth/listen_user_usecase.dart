import '../../../domain.dart';
import '../use_case.dart';

class ListenUserUseCase implements StreamUseCase<MyUser?, void> {
  final UserRepository _userRepository;

  const ListenUserUseCase(this._userRepository);

  @override
  Stream<MyUser?> execute([void input]) {
    return _userRepository.user;
  }
}
