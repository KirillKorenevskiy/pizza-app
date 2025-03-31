import 'package:auto_route/annotations.dart';

import 'orders.gm.dart';

export 'package:orders/orders.dart';
export 'package:orders/orders.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Dialog,Route')
class OrdersModule extends $OrdersModule {}