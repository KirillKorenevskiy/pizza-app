import '../../../domain.dart';
import '../use_case.dart';

class ListenCartUseCase implements StreamUseCase<List<CartItem>, void> {
  final CartRepository _cartRepository;

  const ListenCartUseCase(this._cartRepository);

  @override
  Stream<List<CartItem>> execute([void input]) {
    return _cartRepository.cartStream;
  }
}
