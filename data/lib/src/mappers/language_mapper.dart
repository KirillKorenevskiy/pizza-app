import 'package:domain/domain.dart';

class LanguagesMapper {
  static String toStringValue(LocalizationLanguages language) {
    switch (language) {
      case LocalizationLanguages.english:
        return 'en';
      case LocalizationLanguages.russian:
        return 'ru';
    }
  }

  static LocalizationLanguages fromStringValue(String? code) {
    switch (code) {
      case 'en':
        return LocalizationLanguages.english;
      case 'ru':
        return LocalizationLanguages.russian;
      default:
        return LocalizationLanguages.english;
    }
  }
}
