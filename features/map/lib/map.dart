import 'package:auto_route/annotations.dart';

import 'map.gm.dart';

export 'package:map/map.dart';
export 'package:map/map.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Dialog,Route')
class MapModule extends $MapModule {}