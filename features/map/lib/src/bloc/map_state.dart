part of 'map_cubit.dart';

class MapState {
  final List<Address> addresses;
  final bool isLoading;
  final String? errorMessage;

  MapState({
    this.addresses = const <Address>[],
    this.isLoading = false,
    this.errorMessage,
  });

  MapState copyWith({
    List<Address>? addresses,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MapState(
      addresses: addresses ?? this.addresses,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
