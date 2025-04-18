import '../../../domain.dart';
import '../use_case.dart';

class ClearDetailsUseCase implements FutureUseCase<String, void> {
  final DetailsRepository _detailsRepository;

  const ClearDetailsUseCase(this._detailsRepository);

  @override
  Future<void> execute(String input) {
    return _detailsRepository.clearDetails(input);
  }
}
