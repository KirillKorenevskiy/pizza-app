import 'package:auto_route/annotations.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'bloc/placing_order_cubit.dart';
import 'widgets/placing_order_body.dart';

@RoutePage()
class PlacingOrderScreen extends StatelessWidget {
  final Address address;

  const PlacingOrderScreen({
    required this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlacingOrderCubit>(
      create: (BuildContext context) => PlacingOrderCubit(
        appLocator.get(),
      ),
      child: PlacingOrderBody(
        address: address,
      ),
    );
  }
}
