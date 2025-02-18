import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'bloc/pizzas_cubit.dart';
import 'widgets/pizzas_body.dart';

@RoutePage()
class PizzasScreen extends StatelessWidget {
  const PizzasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PizzasCubit>(
      create: (BuildContext context) => PizzasCubit(
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
      )..getPizzas(),
      child: const PizzasScreenBody(),
    );
  }
}
