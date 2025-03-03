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
          path: '/',
          page: MainScreen.page,
          initial: true,
        ),
        AutoRoute(
          path: '/welcome',
          page: WelcomeScreen.page,
        ),
        AutoRoute(
          path: '/pizza',
          page: PizzasScreen.page,
        ),
        AutoRoute(
          page: DetailsScreen.page,
          path: '/pizza/:id',
        ),
        CustomRoute(
          path: '/cart',
          page: CartScreen.page,
          customRouteBuilder: RouteBuilder.modalDialog,
        ),
      ];
}
