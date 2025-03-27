class Order {
  final String id;
  final String userId;
  final DateTime date;
  final String address;
  final double price;

  Order({
    required this.id,
    required this.userId,
    required this.date,
    required this.address,
    required this.price,
  });

  Order copyWith({
    String? id,
    String? userId,
    DateTime? date,
    String? address,
    double? price,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      address: address ?? this.address,
      price: price ?? this.price,
    );
  }
}
