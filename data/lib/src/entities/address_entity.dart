import 'package:json_annotation/json_annotation.dart';

part 'address_entity.g.dart';

@JsonSerializable()
class AddressEntity {
  final String id;
  final String address;
  final double latitude;
  final double longitude;
  final String type;

  AddressEntity({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.type,
  });

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);
}
