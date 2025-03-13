import 'package:auto_route/annotations.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/map_cubit.dart';
import 'widgets/map_body.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
      create: (BuildContext context) => MapCubit(
        appLocator.get(),
      ),
      child: MapBody(),
    );
  }
}
