import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'widgets/pizzas_body.dart';

@RoutePage()
class PizzasScreen extends StatelessWidget {
  const PizzasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PizzasScreenBody(appLocator.get());
  }
}
