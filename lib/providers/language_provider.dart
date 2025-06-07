import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> toggleLanguage(BuildContext context) async {
    _locale = _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    await context.setLocale(_locale); // دي اللي كانت ناقصة
    notifyListeners();
  }
}
