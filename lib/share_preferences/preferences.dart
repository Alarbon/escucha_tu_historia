import 'package:escucha_tu_historia/config/language_config.dart';
import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _preferences;
  static bool _darkMode = false;
  static String _language = 'es';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  // Modo oscuro
  static bool get darkMode {
    return _preferences.getBool('darkMode') ?? false;
  }

  static set darkMode(bool value) {
    _darkMode = value;
    _preferences.setBool('darkMode', _darkMode);
  }

  // Idioma
  static String get language {
    return _preferences.getString('language') ?? 'es';
  }

  static set language(String value) {
    if (LanguageConfig.operativeLanguages.contains(value)) {
      _language = value;
      _preferences.setString('language', _language);
      S.load(Locale(_language));
    }
  }
}
