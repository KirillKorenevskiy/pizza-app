import 'package:auto_route/annotations.dart';

import 'placing_order.gm.dart';

export 'package:placing_order/placing_order.dart';
export 'package:placing_order/placing_order.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Dialog,Route')
class PlacingOrderModule extends $PlacingOrderModule {}