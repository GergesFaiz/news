import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String _languageCode = 'en';

  String get languageCode => _languageCode;
  String get languageLabel => _languageCode == 'en' ? 'English' : 'Arabic';

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('language') ?? 'en';
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    _languageCode = _languageCode == 'en' ? 'ar' : 'en';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _languageCode);
    notifyListeners();
  }
}
