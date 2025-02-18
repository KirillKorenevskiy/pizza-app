import '../../../domain.dart';
import '../use_case.dart';

class AddToCartUseCase implements FutureUseCase<String, void> {
  final CartRepository _cartRepository;

  const AddToCartUseCase(this._cartRepository);

  @override
  Future<void> execute(String input) {
    return _cartRepository.addToCart(input);
  }
}
