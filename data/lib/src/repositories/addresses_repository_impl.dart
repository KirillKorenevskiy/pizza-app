import 'package:domain/domain.dart';

import '../../data.dart';

class AddressRepositoryImpl implements AddressesRepository {
  final LocalAddressesProvider _localAddressesProvider;

  AddressRepositoryImpl(this._localAddressesProvider);

  @override
  Future<void> deleteAddress(String id) async {
    await _localAddressesProvider.deleteAddress(id);
  }

  @override
  Future<List<Address>> getAllAddresses() async {
    final List<AddressEntity> entities =
        await _localAddressesProvider.getAllAddresses();

    return entities.map(AddressMapper.fromEntity).toList();
  }

  @override
  Future<void> addAddress(Address address) async {
    final AddressEntity entity = AddressMapper.toEntity(address);
    await _localAddressesProvider.insertAddress(entity);
  }

  @override
  Future<void> updateAddress(Address address) async {
    final AddressEntity entity = AddressMapper.toEntity(address);
    await _localAddressesProvider.updateAddress(entity);
  }
}
