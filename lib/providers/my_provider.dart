import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  changeTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }

    notifyListeners();
  }
}
