import '../../../domain.dart';
import '../use_case.dart';

class AddDetailsUseCase implements FutureUseCase<DetailPayload, void> {
  final DetailsRepository _detailsRepository;

  const AddDetailsUseCase(this._detailsRepository);

  @override
  Future<void> execute(DetailPayload input) {
    return _detailsRepository.addDetails(input);
  }
}
