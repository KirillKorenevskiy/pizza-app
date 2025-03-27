import 'package:json_annotation/json_annotation.dart';

part 'order_entity.g.dart';

@JsonSerializable()
class OrderEntity {
  final String id;
  final String userId;
  final DateTime date;
  final String address;
  final double price;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.address,
    required this.price,
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEntityToJson(this);

  OrderEntity copyWith({
    String? id,
    String? userId,
    DateTime? date,
    String? address,
    double? price,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      address: address ?? this.address,
      price: price ?? this.price,
    );
  }
}
