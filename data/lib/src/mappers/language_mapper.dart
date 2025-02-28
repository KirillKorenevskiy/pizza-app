import 'package:domain/domain.dart';

class LanguagesMapper {
  static String toStringValue(LocalizationLanguages language) =>
      switch (language) {
        LocalizationLanguages.english => 'en',
        LocalizationLanguages.russian => 'ru',
      };

  static LocalizationLanguages fromStringValue(String? code) => switch (code) {
        'en' => LocalizationLanguages.english,
        'ru' => LocalizationLanguages.russian,
        _ => LocalizationLanguages.english,
      };
}
