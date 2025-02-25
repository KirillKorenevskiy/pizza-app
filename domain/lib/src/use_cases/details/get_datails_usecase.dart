import '../../../domain.dart';
import '../use_case.dart';

class GetDetailsUseCase implements FutureUseCase<void, List<Details>> {
  final DetailsRepository _detailsRepository;

  const GetDetailsUseCase(this._detailsRepository);

  @override
  Future<List<Details>> execute([void input]) async {
    final List<Details> details = await _detailsRepository.getDetails();

    return details;
  }
}
