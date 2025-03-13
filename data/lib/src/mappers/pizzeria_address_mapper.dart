import 'package:domain/domain.dart';

import '../../data.dart';

class PizzeriaAddressMapper {
  static Address fromEntity(AddressEntity entity) {
    return Address(
      id: entity.id,
      address: entity.address,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }

  static AddressEntity toEntity(Address model) {
    return AddressEntity(
      id: model.id,
      address: model.address,
      latitude: model.latitude,
      longitude: model.longitude,
    );
  }
}
