import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';
import '../providers/remote_pizza_provider.dart';
import '../providers/remote_user_provider.dart';

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
  }

  static void _initProviders(GetIt locator) {
    locator.registerLazySingleton<RemotePizzaProvider>(
      RemotePizzaProvider.new,
    );

    locator.registerLazySingleton<RemoteUserProvider>(
      RemoteUserProvider.new,
    );
  }

  static void _initRepositories(GetIt locator) {
    locator.registerFactory<PizzaRepository>(
      () => PizzaRepositoryImpl(locator<RemotePizzaProvider>()),
    );

    locator.registerFactory<UserRepository>(
      () => UserRepositoryImpl(locator<RemoteUserProvider>()),
    );
  }
}
