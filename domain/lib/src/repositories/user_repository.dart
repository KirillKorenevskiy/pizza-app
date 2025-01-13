import '../models/models.dart';
import '../payloads/payloads.dart';

abstract class UserRepository{
 	Stream<MyUser?> get user;
 	Future<MyUser> signUp(SignUpPayload payload);
 	Future<void> setUserData(MyUser user);
 	Future<void> signIn(SignInPayload payload);
 	Future<void> logOut();
}
