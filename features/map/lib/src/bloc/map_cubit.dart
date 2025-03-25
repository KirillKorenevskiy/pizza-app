import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:latlong2/latlong.dart';
import 'package:navigation/navigation.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetPizzeriasAddressesUseCase _getPizzeriasAddressesUseCase;
  final GetAllAddressesUseCase _getAllAddressesUseCase;
  final AppRouter _appRouter;

  MapCubit(
    this._getPizzeriasAddressesUseCase,
    this._getAllAddressesUseCase,
    this._appRouter,
  ) : super(MapState()) {
    _init();
  }

  Future<void> _init() async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
      final List<Address> pizzeriaAddresses =
          await _getPizzeriasAddressesUseCase.execute();
      final List<Address> localAddresses =
          await _getAllAddressesUseCase.execute();

      final List<Address> allAddresses = <Address>[
        ...localAddresses,
        ...pizzeriaAddresses,
      ];

      emit(
        state.copyWith(
          addresses: allAddresses,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void switchAddingMode() {
    emit(
      state.copyWith(
        isAddingMode: !state.isAddingMode,
      ),
    );
    if (state.isAddingMode == false) _init();
  }

  void switchEditingMode() {
    emit(
      state.copyWith(
        isEditingMode: !state.isEditingMode,
        isAddingMode: false,
      ),
    );
  }

  Future<void> goToAddEditAddress({
    required String initialAddress,
    required LatLng latLng,
    required bool isEditingMode,
    String? addressId,
  }) async {
    await _appRouter.push(
      AddEditAddressScreen(
        initialAddress: initialAddress,
        latLng: latLng,
        isEditingMode: isEditingMode,
        addressId: addressId,
      ),
    );
    await _init();
  }

  Future<void> goToPlacingOrder(Address address) async {
    await _appRouter.push(
      PlacingOrderScreen(address: address),
    );
    await _init();
  }

  void goBack() {
    _appRouter.maybePop();
  }
}
