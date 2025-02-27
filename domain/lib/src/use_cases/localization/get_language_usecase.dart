import '../../../domain.dart';
import '../use_case.dart';

class GetLanguageUseCase
    implements FutureUseCase<void, LocalizationLanguages?> {
  final LocalizationRepository _localizationRepository;

  const GetLanguageUseCase(this._localizationRepository);

  @override
  Future<LocalizationLanguages?> execute([void input]) async {
    final LocalizationLanguages? language =
        await _localizationRepository.getLanguage();

    return language;
  }
}
