import '../../../domain.dart';
import '../use_case.dart';

class DeleteAddressUseCase implements FutureUseCase<String, void> {
  final AddressesRepository _addressesRepository;

  const DeleteAddressUseCase(this._addressesRepository);

  @override
  Future<void> execute(String input) {
    return _addressesRepository.deleteAddress(input);
  }
}
