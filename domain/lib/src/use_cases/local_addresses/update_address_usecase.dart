import '../../../domain.dart';
import '../use_case.dart';

class UpdateAddressUseCase implements FutureUseCase<Address, void> {
  final AddressesRepository _addressesRepository;

  const UpdateAddressUseCase(this._addressesRepository);

  @override
  Future<void> execute(Address input) {
    return _addressesRepository.updateAddress(input);
  }
}
