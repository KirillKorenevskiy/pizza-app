import '../../../domain.dart';
import '../use_case.dart';

class GetCartsUseCase implements FutureUseCase<void, List<CartItem>> {
  final CartRepository _cartRepository;

  const GetCartsUseCase(this._cartRepository);

  @override
  Future<List<CartItem>> execute([void input]) async {
    final List<CartItem> carts = await _cartRepository.getCarts();

    return carts;
  }
}
