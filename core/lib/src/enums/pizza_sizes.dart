enum PizzaSize {
  small(25, '25'),
  medium(30, '30'),
  large(35, '35');

  final int sizeInCm;
  final String label;

  const PizzaSize(this.sizeInCm, this.label);
}

extension PizzaSizeExtension on PizzaSize {
  int get sizeInCm {
    switch (this) {
      case PizzaSize.small:
        return 25;
      case PizzaSize.medium:
        return 30;
      case PizzaSize.large:
        return 35;
    }
  }
}
