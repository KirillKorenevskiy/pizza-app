import '../../../domain.dart';
import '../use_case.dart';

class DeleteDetailsUseCase implements FutureUseCase<String, void> {
  final DetailsRepository _detailsRepository;

  const DeleteDetailsUseCase(this._detailsRepository);

  @override
  Future<void> execute(String input) {
    return _detailsRepository.deleteDetail(input);
  }
}