import 'package:flutter/cupertino.dart';

class LanguageState extends   ChangeNotifier {
  bool _isEnglish = false;

  bool get isEnglish => _isEnglish;

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners(); // Notify listeners about the change
  }
}