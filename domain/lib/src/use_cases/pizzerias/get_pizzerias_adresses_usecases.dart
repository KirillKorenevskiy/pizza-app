import '../../../domain.dart';
import '../use_case.dart';

class GetPizzeriasAddressesUseCase
    implements FutureUseCase<void, List<Address>> {
  final PizzeriasRepository _pizzeriasRepository;

  const GetPizzeriasAddressesUseCase(this._pizzeriasRepository);

  @override
  Future<List<Address>> execute([void input]) async {
    final List<Address> addresses =
        await _pizzeriasRepository.getPizzeriasAddresses();

    return addresses;
  }
}
