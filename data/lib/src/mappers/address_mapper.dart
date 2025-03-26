import 'package:domain/domain.dart';

import '../../data.dart';

class AddressMapper {
  static Address fromEntity(AddressEntity entity) {
    return Address(
      id: entity.id,
      address: entity.address,
      latitude: entity.latitude,
      longitude: entity.longitude,
      type: entity.type,
    );
  }

  static AddressEntity toEntity(Address model) {
    return AddressEntity(
      id: model.id,
      address: model.address,
      latitude: model.latitude,
      longitude: model.longitude,
      type: model.type,
    );
  }
}
