import 'package:navigation/navigation.dart';

import 'welcome.gm.dart';
export 'welcome.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Form,Route')
class WelcomeModule extends $WelcomeModule {}