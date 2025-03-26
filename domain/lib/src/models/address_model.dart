class Address {
  final String id;
  final String address;
  final double latitude;
  final double longitude;
  final String type;

  const Address({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.type,
  });

  Address copyWith({
    String? id,
    String? address,
    double? latitude,
    double? longitude,
    String? type,
  }) {
    return Address(
      id: id ?? this.id,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      type: type ?? this.type,
    );
  }
}
