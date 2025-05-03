import 'package:auto_route/annotations.dart';

import 'adminka.gm.dart';

export 'package:adminka/adminka.dart';
export 'package:adminka/adminka.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Dialog,Route')
class AdminkaModule extends $AdminkaModule {}
