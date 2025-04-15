import '../../../domain.dart';
import '../use_case.dart';

class ClearCartUseCase implements FutureUseCase<String, void> {
  final CartRepository _cartRepository;

  const ClearCartUseCase(this._cartRepository);

  @override
  Future<void> execute(String input) {
    return _cartRepository.clearCart(input);
  }
}
