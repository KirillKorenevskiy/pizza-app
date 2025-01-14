import 'package:core/core.dart';

import '../../domain.dart';

abstract class DomainDI {
  static void initDependencies(GetIt locator) {
    _initUseCases(locator);
  }

  static void _initUseCases(GetIt locator) {
    locator.registerFactory<SignUpUseCase>(
      () => SignUpUseCase(locator.get()),
    );

    locator.registerFactory<SignInUseCase>(
      () => SignInUseCase(locator.get()),
    );

    locator.registerFactory<LogOutUseCase>(
      () => LogOutUseCase(locator.get()),
    );

    locator.registerFactory<ListenUserUseCase>(
      () => ListenUserUseCase(locator.get()),
    );

    locator.registerFactory<GetPizzasUseCase>(
      () => GetPizzasUseCase(locator.get()),
    );
  }
}
