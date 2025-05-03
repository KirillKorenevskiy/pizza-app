import 'package:auto_route/annotations.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'bloc/adminka_cubit.dart';
import 'widget/adminka_body.dart';

@RoutePage()
class AdminkaScreen extends StatelessWidget {
  const AdminkaScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminkaCubit>(
      create: (BuildContext context) => AdminkaCubit(
        appLocator.get(),
      ),
      child: const AdminkaBody(),
    );
  }
}
