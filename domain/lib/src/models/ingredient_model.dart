class Ingredient {
  final String id;
  final String name;
  final double price;
  final String image;

  Ingredient({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  Ingredient copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }
}
