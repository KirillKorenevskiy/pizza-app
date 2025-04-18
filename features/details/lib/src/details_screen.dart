import 'package:auto_route/annotations.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'bloc/details_cubit.dart';
import 'widgets/details_body.dart';

@RoutePage()
class DetailsScreen extends StatelessWidget {
  final String id;

  const DetailsScreen({
    @PathParam('id') required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsCubit>(
      create: (BuildContext context) => DetailsCubit(
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
      ),
      child: DetailsBody(pizzaId: id),
    );
  }
}
