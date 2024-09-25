import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController with ChangeNotifier {
  Locale? _appLocale;

  Locale? get appLocale => _appLocale;
  String get currentLanguageName {
    if (_appLocale?.languageCode == 'es') {
      return 'Spanish';
    }
    return 'English';
  }

  LanguageChangeController() {
    _loadSavedLanguage();
  }

  void changeLanguage(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _appLocale = type;
    if (type == Locale('es')) {
      await sp.setString('Language_code', 'es');
    } else {
      await sp.setString('Language_code', 'en');
    }
    notifyListeners();
  }

  void _loadSavedLanguage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? languageCode = sp.getString('Language_code');
    if (languageCode != null) {
      _appLocale = Locale(languageCode);
      notifyListeners();
    }
  }
}
