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

    locator.registerFactory<GetPizzaByIdUseCase>(
      () => GetPizzaByIdUseCase(locator.get()),
    );

    locator.registerFactory<AddToCartUseCase>(
      () => AddToCartUseCase(locator.get()),
    );

    locator.registerFactory<CheckCartUseCase>(
      () => CheckCartUseCase(locator.get()),
    );

    locator.registerFactory<GetCartsUseCase>(
      () => GetCartsUseCase(locator.get()),
    );

    locator.registerFactory<RemoveFromCartUseCase>(
      () => RemoveFromCartUseCase(locator.get()),
    );

    locator.registerFactory<UpdateQuantityUseCase>(
      () => UpdateQuantityUseCase(locator.get()),
    );

    locator.registerFactory<ListenCartUseCase>(
      () => ListenCartUseCase(locator.get()),
    );

    locator.registerFactory<ClearCartUseCase>(
      () => ClearCartUseCase(locator.get()),
    );

    locator.registerFactory<GetIngredientsUseCase>(
      () => GetIngredientsUseCase(locator.get()),
    );

    locator.registerFactory<GetIngredientsByIdUseCase>(
      () => GetIngredientsByIdUseCase(locator.get()),
    );

    locator.registerFactory<GetDetailsUseCase>(
      () => GetDetailsUseCase(locator.get()),
    );

    locator.registerFactory<GetDetailByIdUseCase>(
      () => GetDetailByIdUseCase(locator.get()),
    );

    locator.registerFactory<UpdateDetailsUseCase>(
      () => UpdateDetailsUseCase(locator.get()),
    );

    locator.registerFactory<DeleteDetailsUseCase>(
      () => DeleteDetailsUseCase(locator.get()),
    );

    locator.registerFactory<AddDetailsUseCase>(
      () => AddDetailsUseCase(locator.get()),
    );

    locator.registerFactory<ClearDetailsUseCase>(
      () => ClearDetailsUseCase(locator.get()),
    );

    locator.registerFactory<ChangeLanguageUseCase>(
      () => ChangeLanguageUseCase(locator.get()),
    );

    locator.registerFactory<GetLanguageUseCase>(
      () => GetLanguageUseCase(locator.get()),
    );

    locator.registerFactory<GetPizzeriasAddressesUseCase>(
      () => GetPizzeriasAddressesUseCase(locator.get()),
    );

    locator.registerFactory<AddAddressUseCase>(
      () => AddAddressUseCase(locator.get()),
    );

    locator.registerFactory<DeleteAddressUseCase>(
      () => DeleteAddressUseCase(locator.get()),
    );

    locator.registerFactory<GetAllAddressesUseCase>(
      () => GetAllAddressesUseCase(locator.get()),
    );

    locator.registerFactory<UpdateAddressUseCase>(
      () => UpdateAddressUseCase(locator.get()),
    );

    locator.registerFactory<AddOrderUseCase>(
      () => AddOrderUseCase(locator.get()),
    );

    locator.registerFactory<GetUserOrdersUseCase>(
      () => GetUserOrdersUseCase(locator.get()),
    );

    locator.registerFactory<GetOrderByIdUseCase>(
      () => GetOrderByIdUseCase(locator.get()),
    );
  }
}
