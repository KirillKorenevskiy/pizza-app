import 'package:auto_route/auto_route.dart';
import 'package:cart/cart.dart';
import 'package:details/details.dart';
import 'package:main/main.dart';
import 'package:pizzas/pizzas.dart';
import 'package:welcome/welcome.dart';

import '../utils/route_builder.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Form|Screen|Step,Route',
  modules: <Type>[
    MainModule,
    WelcomeModule,
    PizzasModule,
    CartModule,
    DetailsModule,
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
        ),
        CustomRoute(
          page: CartScreen.page,
          customRouteBuilder: RouteBuilder.modalDialog,
        ),
        AutoRoute(
          page: DetailsScreen.page,
        ),
      ];
}
