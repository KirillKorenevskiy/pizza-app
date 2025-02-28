import '../../../domain.dart';
import '../use_case.dart';

class ChangeLanguageUseCase
    implements FutureUseCase<LocalizationLanguages, void> {
  final LocalizationRepository _localizationRepository;

  const ChangeLanguageUseCase(this._localizationRepository);

  @override
  Future<void> execute(LocalizationLanguages language) async {
    await _localizationRepository.changeLanguage(language);
  }
}
