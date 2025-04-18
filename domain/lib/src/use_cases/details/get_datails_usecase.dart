import '../../../domain.dart';
import '../use_case.dart';

class GetDetailsUseCase implements FutureUseCase<String, List<Details>> {
  final DetailsRepository _detailsRepository;

  const GetDetailsUseCase(this._detailsRepository);

  @override
  Future<List<Details>> execute(String input) async {
    final List<Details> details = await _detailsRepository.getDetails(input);

    return details;
  }
}
