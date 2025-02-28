import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data.dart';

abstract class DataDI {
  static void initDependencies(GetIt locator) {
    _initApi(locator);
    _initProviders(locator);
    _initRepositories(locator);
  }

  static Future<void> _initApi(GetIt locator) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    locator.registerLazySingleton<SharedPreferences>(
          () => sharedPreferences,
    );

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

    locator.registerLazySingleton<LocalDetailsProvider>(
      () => LocalDetailsProvider(locator<DatabaseConfig>()),
    );

    locator.registerLazySingleton<LocalLocalizationProvider>(
      () => LocalLocalizationProvider(locator<SharedPreferences>()),
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
        locator<LocalDetailsProvider>(),
        locator<RemoteIngredientsProvider>(),
      ),
    );

    locator.registerFactory<IngredientsRepository>(
      () => IngredientsRepositoryImpl(locator<RemoteIngredientsProvider>()),
    );

    locator.registerFactory<DetailsRepository>(
      () => DetailsRepositoryImpl(locator<LocalDetailsProvider>()),
    );

    locator.registerLazySingleton<LocalizationRepository>(
      () => LocalizationRepositoryImpl(locator<LocalLocalizationProvider>()),
    );
  }
}
