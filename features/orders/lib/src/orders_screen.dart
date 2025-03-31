import 'package:auto_route/annotations.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'bloc/orders_cubit.dart';
import 'widgets/orders_body.dart';

@RoutePage()
class OrdersScreen extends StatelessWidget {
  final String userId;

  const OrdersScreen({
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersCubit>(
      create: (BuildContext context) => OrdersCubit(
        appLocator.get(),
        appLocator.get(),
      )..getOrders(userId),
      child: const OrdersBody(),
    );
  }
}
