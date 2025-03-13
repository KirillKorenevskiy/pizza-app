import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetPizzeriasAddressesUseCase _getPizzeriasAddressesUseCase;

  MapCubit(this._getPizzeriasAddressesUseCase) : super(MapState()) {
    _init();
  }

  Future<void> _init() async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
      final List<Address> addresses =
          await _getPizzeriasAddressesUseCase.execute();

      emit(
        state.copyWith(
          addresses: addresses,
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
}
