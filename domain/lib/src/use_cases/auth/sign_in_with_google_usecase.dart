import '../../../domain.dart';
import '../use_case.dart';

class SignInWithGoogleUseCase implements FutureUseCase<void, void>{
  final UserRepository _userRepository;

  const SignInWithGoogleUseCase(this._userRepository);

  @override
  Future<void> execute([void input]) async{
    return _userRepository.signInWithGoogle();
  }
}
