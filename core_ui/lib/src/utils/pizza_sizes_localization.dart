import 'package:domain/domain.dart';

extension PizzaSizeLocalization on PizzaSize {
  String toLabel() {
    switch (this) {
      case PizzaSize.small:
        return '25';
      case PizzaSize.medium:
        return '30';
      case PizzaSize.large:
        return '35';
    }
  }
}
