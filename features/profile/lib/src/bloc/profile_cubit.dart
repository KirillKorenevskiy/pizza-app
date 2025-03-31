import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AppRouter _appRouter;
  final LogOutUseCase _logOutUseCase;

  ProfileCubit(
    this._appRouter,
    this._logOutUseCase,
  ) : super(ProfileState());

  void goToOrders(String id) {
    _appRouter.push(
      OrdersScreen(userId: id),
    );
  }

  Future<void> logOut() async {
    await _logOutUseCase.execute();
  }
}
