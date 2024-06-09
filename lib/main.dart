import 'package:escucha_tu_historia/config/language_config.dart';
import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:escucha_tu_historia/providers/monuments_provider.dart';
import 'package:escucha_tu_historia/providers/routes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/audio_provider.dart';
import 'providers/settings_provider.dart';
import 'config/router/app_router.dart';
import 'share_preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AudioProvider(),
          lazy: false,
        ),
         ChangeNotifierProvider(
          create: (_) => RoutesProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => MonumentsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp.router(
      title: 'Escucha tu historia - Martos',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      locale: Locale(Preferences.language),
      localizationsDelegates: const [
        S.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LanguageConfig.operativeLanguages
          .map((lang) => Locale(lang, lang.toUpperCase())), // cargar idiomas

      theme: settingsProvider.darkMode
          ? ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(primary: Colors.blueAccent),
              primaryColor: Colors.blueAccent,
              hintColor: Colors.deepPurpleAccent,
              buttonTheme: const ButtonThemeData(
                buttonColor: Colors.blueAccent,
                textTheme: ButtonTextTheme.primary,
              ),
            )
          : ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: Colors.deepPurple),
              primaryColor: Colors.deepPurple,
              hintColor: Colors.deepPurpleAccent,
              buttonTheme: const ButtonThemeData(
                buttonColor: Colors.deepPurple,
                textTheme: ButtonTextTheme.primary,
              ),
            ),
    );
  }
}
