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
  ) : super(const AddEditAddressState()) {
    updateCategory('home');
  }

  void updateCategory(String newCategory) {
    emit(
      state.copyWith(
        category: newCategory,
      ),
    );
  }

  Future<void> saveAddress(
    LatLng latLng,
    String address,
  ) async {
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
          address: address,
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
    String address,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final Address updatedAddress = Address(
      id: addressId,
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      address: address,
      type: state.category,
    );

    try {
      await _updateAddressUseCase.execute(updatedAddress);
      await _appRouter.replace(
        PlacingOrderScreen(
          address: updatedAddress,
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
