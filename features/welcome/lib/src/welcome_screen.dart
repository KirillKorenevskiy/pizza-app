import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:nested/nested.dart';

import 'bloc/sign_in/sign_in_cubit.dart';
import 'bloc/sign_up/sign_up_cubit.dart';
import 'widgets/welcome_body.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<SignInCubit>(
          create: (BuildContext context) => SignInCubit(
            appLocator.get(),
            appLocator.get(),
          ),
        ),
        BlocProvider<SignUpCubit>(
          create: (BuildContext context) => SignUpCubit(
            appLocator.get(),
          ),
        ),
      ],
      child: const WelcomeScreenBody(),
    );
  }
}
