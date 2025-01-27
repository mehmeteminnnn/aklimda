import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/translations.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'tr';  // Varsayılan dil Türkçe
  static const String _languageKey = 'language_code';

  LanguageProvider() {
    _loadLanguage();
  }

  String get currentLanguage => _currentLanguage;

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(_languageKey) ?? 'tr';  // Varsayılan dil Türkçe
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
      notifyListeners();
    }
  }

  String getText(String key) {
    return Translations.get(key, _currentLanguage);
  }
}
