import 'package:json_annotation/json_annotation.dart';

part 'order_entity.g.dart';

@JsonSerializable()
class OrderEntity {
  final String id;
  final String userId;
  final String date;
  final String address;
  final double price;
  final List<String> items;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.address,
    required this.price,
    required this.items,
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEntityToJson(this);

  OrderEntity copyWith({
    String? id,
    String? userId,
    String? date,
    String? address,
    double? price,
    List<String>? items,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      address: address ?? this.address,
      price: price ?? this.price,
      items: items ?? this.items,
    );
  }
}
