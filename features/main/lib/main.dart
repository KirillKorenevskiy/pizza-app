import 'package:navigation/navigation.dart';

export 'main.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Form,Route')
class MainModule extends $MainModule {}
