import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  //todo:Data
  Locale appLanguage = Locale('en');
  bool get isEnglish => appLanguage == Locale('en');

  //todo:FunctionData
  void changeLanguage() {
    if (appLanguage == Locale('en'))
      appLanguage = Locale('ar');
    else {
      appLanguage = Locale('en');
    }
    notifyListeners();
  }
}
