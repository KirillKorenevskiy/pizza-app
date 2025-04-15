import '../../../domain.dart';
import '../use_case.dart';

class AddToCartUseCase implements FutureUseCase<CartPayload, void> {
  final CartRepository _cartRepository;

  const AddToCartUseCase(this._cartRepository);

  @override
  Future<void> execute(CartPayload input) {
    return _cartRepository.addToCart(input);
  }
}
