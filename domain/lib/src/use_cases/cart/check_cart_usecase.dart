import '../../../domain.dart';
import '../use_case.dart';

class CheckCartUseCase implements FutureUseCase<CartPayload, bool> {
  final CartRepository _cartRepository;

  const CheckCartUseCase(this._cartRepository);

  @override
  Future<bool> execute(CartPayload input) {
    return _cartRepository.isInCart(input);
  }
}
