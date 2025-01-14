import '../../../domain.dart';
import '../use_case.dart';

class SignUpUseCase implements FutureUseCase<SignUpPayload, MyUser> {
  final UserRepository _userRepository;

  const SignUpUseCase(this._userRepository);

  @override
  Future<MyUser> execute(SignUpPayload input) async {
    final MyUser newUser = await _userRepository.signUp(input);
    await _userRepository.setUserData(newUser);

    return newUser;
  }
}
