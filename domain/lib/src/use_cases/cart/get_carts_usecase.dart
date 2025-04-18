import '../../../domain.dart';
import '../use_case.dart';

class GetCartsUseCase implements FutureUseCase<String, List<CartItem>> {
  final CartRepository _cartRepository;

  const GetCartsUseCase(this._cartRepository);

  @override
  Future<List<CartItem>> execute(String input) async {
    final List<CartItem> carts = await _cartRepository.getCarts(input);

    return carts;
  }
}
