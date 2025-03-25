import '../../../domain.dart';
import '../use_case.dart';

class GetAllAddressesUseCase implements FutureUseCase<void, List<Address>> {
  final AddressesRepository _addressesRepository;

  const GetAllAddressesUseCase(this._addressesRepository);

  @override
  Future<List<Address>> execute([void input]) async {
    final List<Address> addresses =
        await _addressesRepository.getAllAddresses();

    return addresses;
  }
}
