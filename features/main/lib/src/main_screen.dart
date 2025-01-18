import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (BuildContext context) => AppCubit(
        appLocator.get(),
        appLocator.get(),
      ),
      child: BlocListener<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state.status == AppStatus.authenticated) {
            context.read<AppCubit>().goToPizzasScreen();
          } else if (state.status == AppStatus.unauthenticated) {
            context.read<AppCubit>().goToWelcomeScreen();
          }
        },
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
