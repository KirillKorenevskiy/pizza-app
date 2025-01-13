import '../../../data.dart';

class SignUpRequest{
  final UserEntity myUser;
  final String password;

  const SignUpRequest({
    required this.myUser,
    required this.password,
  });
}
