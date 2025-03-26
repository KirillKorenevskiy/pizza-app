import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:latlong2/latlong.dart';
import 'package:navigation/navigation.dart';

part 'add_edit_address_state.dart';

class AddEditAddressCubit extends Cubit<AddEditAddressState> {
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final AppRouter _appRouter;

  AddEditAddressCubit(
    this._addAddressUseCase,
    this._updateAddressUseCase,
    this._deleteAddressUseCase,
    this._appRouter,
  ) : super(const AddEditAddressState());

  void updateAddressField(String newAddress) {
    emit(
      state.copyWith(
        address: newAddress,
      ),
    );
  }

  void updateCategory(String newCategory) {
    emit(
      state.copyWith(
        category: newCategory,
      ),
    );
  }

  Future<void> saveAddress(LatLng latLng) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    try {
      await _addAddressUseCase.execute(
        Address(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          latitude: latLng.latitude,
          longitude: latLng.longitude,
          address: state.address,
          type: state.category,
        ),
      );
      await _appRouter.maybePop();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateAddress(
    String addressId,
    LatLng latLng,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final Address address = Address(
      id: addressId,
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      address: state.address,
      type: state.category,
    );

    try {
      await _updateAddressUseCase.execute(address);
      await _appRouter.replace(
        PlacingOrderScreen(
          address: address,
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

  Future<void> deleteAddress(String addressId) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    try {
      await _deleteAddressUseCase.execute(addressId);
      await _appRouter.maybePop();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
