import 'package:auto_route/auto_route.dart';
import 'package:welcome/welcome.dart';


part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Form|Screen|Step,Route',
  modules: <Type>[
    WelcomeModule
  ],
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: WelcomeScreen.page, initial: true)
  ];
}





