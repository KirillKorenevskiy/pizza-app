import 'package:auto_route/annotations.dart';

import 'profile.gm.dart';

export 'package:profile/profile.dart';
export 'package:profile/profile.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Dialog,Route')
class ProfileModule extends $ProfileModule {}