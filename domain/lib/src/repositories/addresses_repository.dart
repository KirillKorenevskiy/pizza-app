import '../../domain.dart';

abstract interface class AddressesRepository {
  Future<void> addAddress(Address address);

  Future<void> updateAddress(Address address);

  Future<List<Address>> getAllAddresses();

  Future<void> deleteAddress(String id);
}
