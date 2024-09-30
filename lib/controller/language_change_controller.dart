import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController with ChangeNotifier {
  Locale? _appLocale;
  Locale? get appLocale => _appLocale;

  Future<void> saveLanguage(String langCode) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('language_code', langCode);
  }

  Future<void> loadLanguage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? languageCode = sp.getString('language_code');

    if (languageCode != null) {
      _appLocale = Locale(languageCode);
    } else {
      _appLocale = Locale('en'); // Default to English if no language is saved
    }
    notifyListeners(); // Notify listeners after loading the language
  }

  void changeLanguage(Locale type) async {
    _appLocale = type;

    await saveLanguage(type.languageCode);

    notifyListeners(); // Notify listeners after changing the language
  }
}