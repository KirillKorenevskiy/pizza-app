import '../../../domain.dart';
import '../use_case.dart';

class RemoveFromCartUseCase implements FutureUseCase<String, void> {
  final CartRepository _cartRepository;

  const RemoveFromCartUseCase(this._cartRepository);

  @override
  Future<void> execute(String input) {
    return _cartRepository.removeFromCart(input);
  }
}
