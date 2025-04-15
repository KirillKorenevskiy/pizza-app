import '../../../domain.dart';
import '../use_case.dart';

class RemoveFromCartUseCase implements FutureUseCase<CartPayload, void> {
  final CartRepository _cartRepository;

  const RemoveFromCartUseCase(this._cartRepository);

  @override
  Future<void> execute(CartPayload input) {
    return _cartRepository.removeFromCart(input);
  }
}
