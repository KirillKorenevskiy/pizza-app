import 'package:auto_route/annotations.dart';

import 'details.gm.dart';

export 'package:details/details.dart';
export 'package:details/details.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Dialog,Route')
class DetailsModule extends $DetailsModule {}