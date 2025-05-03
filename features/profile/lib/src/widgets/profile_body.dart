import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/profile_cubit.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (BuildContext context, AppState state) {
        final AppColors colors = AppColors.of(context);
        final AppCubit appCubit = context.read<AppCubit>();
        final String userId = state.user!.userId;
        final String email = state.user!.email;

        return Scaffold(
          appBar: AppBar(
            title: Text(context.locale.profile),
            centerTitle: true,
            backgroundColor: colors.white,
          ),
          body: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: colors.grey,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                state.user!.email,
                style: TextStyle(
                  color: colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (BuildContext context, ProfileState state) {
                  final ProfileCubit profileCubit =
                      context.read<ProfileCubit>();

                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(
                          Icons.receipt_long,
                          size: 30,
                        ),
                        title: Text(
                          context.locale.myOrders,
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: () => profileCubit.goToOrders(userId),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.language,
                          size: 30,
                        ),
                        title: Text(
                          context.locale.changeLanguage,
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: appCubit.changeLanguage,
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                          size: 30,
                        ),
                        title: Text(
                          context.locale.logOut,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        onTap: profileCubit.logOut,
                      ),
                      email == 'admin@gmail.com'
                          ? ListTile(
                              leading: const Icon(
                                Icons.exit_to_app,
                                color: Colors.black,
                                size: 30,
                              ),
                              title: const Text(
                                'Admin panel',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                context.read<ProfileCubit>().goToAdminPanel();
                              },
                            )
                          : const SizedBox.shrink(),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
