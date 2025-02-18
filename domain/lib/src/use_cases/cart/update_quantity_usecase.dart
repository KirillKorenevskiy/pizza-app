import '../../../domain.dart';
import '../use_case.dart';

class UpdateQuantityUseCase
    implements FutureUseCase<UpdateQuantityPayload, void> {
  final CartRepository _cartRepository;

  const UpdateQuantityUseCase(this._cartRepository);

  @override
  Future<void> execute(UpdateQuantityPayload input) {
    return _cartRepository.updateQuantity(input);
  }
}
