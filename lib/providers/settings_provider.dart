import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../share_preferences/preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;

  String version = '';

  String nameApp = "";

  String buildNumber = '';

  String _selectedLanguage = 'es';

  bool isHomeScreen = true;

  final _advancedDrawerController = AdvancedDrawerController();

  SettingsProvider() {
    _darkMode = Preferences.darkMode;
    _selectedLanguage = Preferences.language;
    PackageInfo.fromPlatform().then((info) {
      version = info.version;
      nameApp = info.appName;
      buildNumber = info.buildNumber;
    });
    notifyListeners();
  }

  bool get darkMode => _darkMode;

  AdvancedDrawerController get advancedDrawerController =>
      _advancedDrawerController;

  String get selectedLanguage => _selectedLanguage;

  set darkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  void changeLanguage(BuildContext context, String language) {
    _selectedLanguage = language;
    Preferences.language = language;
    snackMessage(context);
    notifyListeners();
  }

  /// This method is used to change the theme of the app
  void toggleTheme() {
    darkMode = !darkMode;
    Preferences.darkMode = darkMode;
    notifyListeners();
  }

  /// This method is used to show the drawer when the menu button is pressed
  void handleMenuButtonPressed(BuildContext context) {
    if (context.findRenderObject()?.attached == true) {
      if (_advancedDrawerController.value.visible) {
        _advancedDrawerController.hideDrawer();
      } else {
        _advancedDrawerController.showDrawer();
      }
    }
    notifyListeners();
  }

  void snackMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: darkMode ? const Color(0xff004832) : Colors.green,
        content: Text(
          S.current.selected_language_text,
          style: TextStyle(color: darkMode ? Colors.white : Colors.black),
        ),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          backgroundColor: !darkMode ? const Color(0xff004832) : Colors.green,
          label: S.current.close,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
