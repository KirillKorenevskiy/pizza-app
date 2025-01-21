import 'package:auto_route/auto_route.dart';
import 'package:main/main.dart';
import 'package:pizzas/pizzas.dart';
import 'package:welcome/welcome.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Form|Screen|Step,Route',
  modules: <Type>[
    MainModule,
    WelcomeModule,
    PizzasModule,
  ],
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: MainScreen.page,
          initial: true,
        ),
        AutoRoute(
          page: WelcomeScreen.page,
        ),
        AutoRoute(
          page: PizzasScreen.page,
        )
      ];
}
