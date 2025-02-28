import '../../domain.dart';

abstract interface class LocalizationRepository {
  Future<void> changeLanguage(LocalizationLanguages language);

  Future<LocalizationLanguages?> getLanguage();
}
