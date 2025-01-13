import '../../domain.dart';

class SignUpPayload{
  final MyUser myUser;
  final String password;

  const SignUpPayload({
    required this.myUser,
    required this.password,
  });
}
