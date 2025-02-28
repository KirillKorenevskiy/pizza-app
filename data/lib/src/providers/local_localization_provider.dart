import 'package:shared_preferences/shared_preferences.dart';

class LocalLocalizationProvider {
  final SharedPreferences _sharedPreferences;

  LocalLocalizationProvider(this._sharedPreferences);

  Future<void> changeLanguage(String language) async {
    await _sharedPreferences.setString('language', language);
  }

  Future<String?> getLanguage() async {
    final String? language = _sharedPreferences.getString('language');

    return language;
  }
}
