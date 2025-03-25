import 'package:auto_route/annotations.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'bloc/map_cubit.dart';
import 'widgets/map_body.dart';

@RoutePage()
class MapScreen extends StatelessWidget {
  final bool isEditingMode;
  final Address? address;

  const MapScreen({
    required this.isEditingMode,
    this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
      create: (BuildContext context) => MapCubit(
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
      ),
      child: MapBody(
        isEditingMode: isEditingMode,
        address: address,
      ),
    );
  }
}
