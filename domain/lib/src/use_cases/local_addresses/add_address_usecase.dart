import '../../../domain.dart';
import '../use_case.dart';

class AddAddressUseCase implements FutureUseCase<Address, void> {
  final AddressesRepository _addressesRepository;

  const AddAddressUseCase(this._addressesRepository);

  @override
  Future<void> execute(Address input) {
    return _addressesRepository.addAddress(input);
  }
}
