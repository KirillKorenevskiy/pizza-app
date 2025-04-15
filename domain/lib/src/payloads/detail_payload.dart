class DetailPayload {
  final String id;
  final String userId;
  final int? size;
  final String? ingredients;

  const DetailPayload({
    required this.id,
    required this.userId,
    required this.size,
    required this.ingredients,
  });
}
