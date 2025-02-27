import 'package:domain/domain.dart';

import '../../data.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  final LocalLocalizationProvider _localizationProvider;

  LocalizationRepositoryImpl(
    this._localizationProvider,
  );

  @override
  Future<void> changeLanguage(LocalizationLanguages language) async {
    await _localizationProvider.changeLanguage(
      LanguagesMapper.toStringValue(language),
    );
  }

  @override
  Future<LocalizationLanguages?> getLanguage() async {
    final String? language = await _localizationProvider.getLanguage();

    return LanguagesMapper.fromStringValue(language);
  }
}
