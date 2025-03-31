import 'package:auto_route/annotations.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/profile_cubit.dart';
import 'widgets/profile_body.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (BuildContext context) => ProfileCubit(
        appLocator.get(),
        appLocator.get(),
      ),
      child: const ProfileBody(),
    );
  }
}
