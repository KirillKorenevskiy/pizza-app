class Order {
  final String id;
  final String userId;
  final String date;
  final String address;
  final double price;
  final List<String> items;

  Order({
    required this.id,
    required this.userId,
    required this.date,
    required this.address,
    required this.price,
    required this.items,
  });

  Order copyWith({
    String? id,
    String? userId,
    String? date,
    String? address,
    double? price,
    List<String>? items,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      address: address ?? this.address,
      price: price ?? this.price,
      items: items ?? this.items,
    );
  }
}
