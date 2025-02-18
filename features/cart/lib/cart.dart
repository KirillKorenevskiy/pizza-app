import 'package:navigation/navigation.dart';

export 'cart.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Form,Route')
class CartModule extends $CartModule {}
