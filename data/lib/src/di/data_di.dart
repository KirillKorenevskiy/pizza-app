import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

abstract class DataDI {
  static void initDependencies(GetIt locator) {
    _initApi(locator);
    _initProviders(locator);
    _initRepositories(locator);
  }

  static void _initApi(GetIt locator) {
    locator.registerLazySingleton<DioConfig>(
      () => DioConfig(
        appConfig: locator<AppConfig>(),
      ),
    );

    locator.registerLazySingleton<ErrorHandler>(
      () => ErrorHandler(
        eventNotifier: locator<AppEventNotifier>(),
      ),
    );

    locator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        locator<DioConfig>().dio,
      ),
    );

    locator.registerLazySingleton<DatabaseConfig>(
      DatabaseConfig.new,
    );
  }

  static void _initProviders(GetIt locator) {
    locator.registerLazySingleton<RemotePizzaProvider>(
      RemotePizzaProvider.new,
    );

    locator.registerLazySingleton<RemoteUserProvider>(
      RemoteUserProvider.new,
    );

    locator.registerLazySingleton<LocalCartProvider>(
      () => LocalCartProvider(locator<DatabaseConfig>()),
    );

    locator.registerLazySingleton<RemoteIngredientsProvider>(
      RemoteIngredientsProvider.new,
    );
  }

  static void _initRepositories(GetIt locator) {
    locator.registerFactory<PizzaRepository>(
      () => PizzaRepositoryImpl(locator<RemotePizzaProvider>()),
    );

    locator.registerFactory<UserRepository>(
      () => UserRepositoryImpl(locator<RemoteUserProvider>()),
    );

    locator.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(
        locator<LocalCartProvider>(),
        locator<RemotePizzaProvider>(),
      ),
    );

    locator.registerFactory<IngredientsRepository>(
      () => IngredientsRepositoryImpl(locator<RemoteIngredientsProvider>()),
    );
  }
}
