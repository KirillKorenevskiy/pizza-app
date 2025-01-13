class Macros {
  final int calories;
  final int proteins;
  final int fat;
  final int carbs;

  Macros({
    required this.calories,
    required this.proteins,
    required this.fat,
    required this.carbs,
  });

  Macros copyWith({
    int? calories,
    int? proteins,
    int? fat,
    int? carbs,
  }) {
    return Macros(
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
    );
  }
}
