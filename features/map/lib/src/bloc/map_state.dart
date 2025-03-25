part of 'map_cubit.dart';

class MapState {
  final bool isLoading;
  final List<Address> addresses;
  final String? errorMessage;
  final bool isAddingMode;
  final bool isEditingMode;

  MapState({
    this.isLoading = false,
    this.addresses = const <Address>[],
    this.errorMessage,
    this.isAddingMode = false,
    this.isEditingMode = false,
  });

  MapState copyWith({
    bool? isLoading,
    List<Address>? addresses,
    String? errorMessage,
    bool? isAddingMode,
    bool? isEditingMode,
  }) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      addresses: addresses ?? this.addresses,
      errorMessage: errorMessage ?? this.errorMessage,
      isAddingMode: isAddingMode ?? this.isAddingMode,
      isEditingMode: isEditingMode ?? this.isEditingMode,
    );
  }
}
