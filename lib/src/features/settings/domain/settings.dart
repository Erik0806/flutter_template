import 'package:flutter/material.dart';

class Settings {
  Settings({
    this.themeMode = ThemeMode.system,
    this.localizationCountryCode = 'de',
  });

  ThemeMode themeMode;
  String localizationCountryCode;
}
