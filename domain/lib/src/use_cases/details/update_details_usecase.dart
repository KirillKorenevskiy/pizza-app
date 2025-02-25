import '../../../domain.dart';
import '../use_case.dart';

class UpdateDetailsUseCase implements FutureUseCase<DetailPayload, void> {
  final DetailsRepository _detailsRepository;

  const UpdateDetailsUseCase(this._detailsRepository);

  @override
  Future<void> execute(DetailPayload input) {
    return _detailsRepository.updateDetail(input);
  }
}
