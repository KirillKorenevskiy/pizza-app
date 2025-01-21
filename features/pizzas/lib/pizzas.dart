import 'package:navigation/navigation.dart';

export 'pizzas.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Form,Route')
class PizzasModule extends $PizzasModule {}
