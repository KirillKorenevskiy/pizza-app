import '../../../domain.dart';
import '../use_case.dart';

class CheckCartUseCase implements FutureUseCase<String, bool> {
  final CartRepository _cartRepository;

  const CheckCartUseCase(this._cartRepository);

  @override
  Future<bool> execute(String input) {
    return _cartRepository.isInCart(input);
  }
}
