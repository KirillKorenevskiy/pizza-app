import 'package:domain/domain.dart';

import '../../data.dart';

class PizzeriasRepositoryImpl implements PizzeriasRepository {
  final RemotePizzeriasProvider _pizzeriasProvider;

  PizzeriasRepositoryImpl(this._pizzeriasProvider);

  @override
  Future<List<Address>> getPizzeriasAddresses() async {
    final List<AddressEntity> entities =
        await _pizzeriasProvider.getPizzeriasAddresses();

    return entities.map(PizzeriaAddressMapper.fromEntity).toList();
  }
}
