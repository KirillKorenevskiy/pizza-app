import 'package:domain/domain.dart';

import '../../data.dart';

class OrderMapper {
  static Order fromEntity(OrderEntity entity) {
    return Order(
      id: entity.id,
      userId: entity.userId,
      date: entity.date,
      address: entity.address,
      price: entity.price,
    );
  }

  static OrderEntity toEntity(Order model) {
    return OrderEntity(
      id: model.id,
      userId: model.userId,
      date: model.date,
      address: model.address,
      price: model.price,
    );
  }
}
