part of 'add_edit_address_cubit.dart';

class AddEditAddressState {
  final String address;
  final String category;
  final bool isEditingMode;
  final bool isLoading;
  final String? errorMessage;

  const AddEditAddressState({
    this.address = '',
    this.category = 'home',
    this.isEditingMode = false,
    this.isLoading = false,
    this.errorMessage,
  });

  AddEditAddressState copyWith({
    String? addressId,
    String? address,
    String? category,
    bool? isEditingMode,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AddEditAddressState(
      address: address ?? this.address,
      category: category ?? this.category,
      isEditingMode: isEditingMode ?? this.isEditingMode,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
