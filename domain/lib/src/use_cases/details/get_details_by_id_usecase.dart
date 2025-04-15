import '../../../domain.dart';
import '../use_case.dart';

class GetDetailByIdUseCase
    implements FutureUseCase<GetDeleteDetailPayload, Details?> {
  final DetailsRepository _detailsRepository;

  const GetDetailByIdUseCase(this._detailsRepository);

  @override
  Future<Details?> execute(GetDeleteDetailPayload input) async {
    final Details? details = await _detailsRepository.getDetailById(input);

    return details;
  }
}
