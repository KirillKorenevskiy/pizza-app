import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      lazy: false,
      create: (BuildContext context) => AppCubit(
        appLocator.get(),
        appLocator.get(),
      ),
      child: const CircularProgressIndicator(),
    );
  }
}
