import '../../../domain.dart';
import '../use_case.dart';

class ClearDetailsUseCase implements FutureUseCase<void, void> {
  final DetailsRepository _detailsRepository;

  const ClearDetailsUseCase(this._detailsRepository);

  @override
  Future<void> execute([void input]) {
    return _detailsRepository.clearDetails();
  }
}
