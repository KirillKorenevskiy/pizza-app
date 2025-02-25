import '../../../domain.dart';
import '../use_case.dart';

class GetDetailByIdUseCase implements FutureUseCase<String, Details?> {
  final DetailsRepository _detailsRepository;

  const GetDetailByIdUseCase(this._detailsRepository);

  @override
  Future<Details?> execute(String input) async {
    final Details? details = await _detailsRepository.getDetailById(input);

    return details;
  }
}
