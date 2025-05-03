import 'package:add_edit_address/add_edit_address.dart';
import 'package:adminka/adminka.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cart/cart.dart';
import 'package:details/details.dart';
import 'package:main/main.dart';
import 'package:map/map.dart';
import 'package:orders/orders.dart';
import 'package:pizzas/pizzas.dart';
import 'package:placing_order/placing_order.dart';
import 'package:profile/profile.dart';
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
    MapModule,
    PlacingOrderModule,
    AddEditAddressModule,
    ProfileModule,
    OrdersModule,
    AdminkaModule,
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
        AutoRoute(
          page: MapScreen.page,
        ),
        CustomRoute(
          page: AddEditAddressScreen.page,
          customRouteBuilder: RouteBuilder.modalDialog,
        ),
        CustomRoute(
          page: PlacingOrderScreen.page,
          customRouteBuilder: RouteBuilder.modalDialog,
        ),
        AutoRoute(
          page: ProfileScreen.page,
        ),
        CustomRoute(
          page: OrdersScreen.page,
          customRouteBuilder: RouteBuilder.modalDialog,
        ),
        AutoRoute(
          page: AdminkaScreen.page,
        ),
      ];
}
