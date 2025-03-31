import '../../../domain.dart';
import '../use_case.dart';

class ClearCartUseCase implements FutureUseCase<void, void> {
  final CartRepository _cartRepository;

  const ClearCartUseCase(this._cartRepository);

  @override
  Future<void> execute([void input]) {
    return _cartRepository.clearCart();
  }
}
