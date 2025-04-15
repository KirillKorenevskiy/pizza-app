import '../../../domain.dart';
import '../use_case.dart';

class DeleteDetailsUseCase
    implements FutureUseCase<GetDeleteDetailPayload, void> {
  final DetailsRepository _detailsRepository;

  const DeleteDetailsUseCase(this._detailsRepository);

  @override
  Future<void> execute(GetDeleteDetailPayload input) {
    return _detailsRepository.deleteDetail(input);
  }
}
