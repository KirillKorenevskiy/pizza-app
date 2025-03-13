class Address {
  final String id;
  final String address;
  final double latitude;
  final double longitude;

  Address({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Address copyWith({
    String? id,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return Address(
      id: id ?? this.id,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
