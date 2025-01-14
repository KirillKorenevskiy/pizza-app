import '../../../domain.dart';
import '../use_case.dart';

class SignInUseCase implements FutureUseCase<SignInPayload, void>{
  final UserRepository _userRepository;

  const SignInUseCase(this._userRepository);

  @override
  Future<void> execute(SignInPayload input) async{
    return _userRepository.signIn(input);
  }
}
