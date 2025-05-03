import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'error_handler/provider/app_error_handler_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Supabase.initialize(
    url: 'https://ympofjjzwcdlmiaoxeik.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InltcG9mamp6d2NkbG1pYW94ZWlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU4NDc0MTcsImV4cCI6MjA2MTQyMzQxN30.oCrHuAv4ZsiOlePt7GStV3WwXWnPBN3V5Np-p4U5KTM',
  );

  _setupDI(Flavor.dev);

  runApp(const App());
}

void _setupDI(Flavor flavor) {
  appLocator.pushNewScope(
    scopeName: unauthScope,
    init: (_) {
      AppDI.initDependencies(appLocator, flavor);
      DataDI.initDependencies(appLocator);
      DomainDI.initDependencies(appLocator);
      NavigationDI.initDependencies(appLocator);
    },
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = appLocator<AppRouter>();

    return BlocProvider<AppCubit>(
      create: (BuildContext context) => AppCubit(
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
        appLocator.get(),
      ),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
          return AppErrorHandlerProvider(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter.config(
                deepLinkBuilder: (PlatformDeepLink link) {
                  return link;
                },
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(state.language.language),
              theme: lightTheme,
            ),
          );
        },
      ),
    );
  }
}
