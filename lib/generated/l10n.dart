// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Routes`
  String get routes {
    return Intl.message(
      'Routes',
      name: 'routes',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get about {
    return Intl.message(
      'About us',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Error page: Route not found`
  String get error {
    return Intl.message(
      'Error page: Route not found',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `How to get?`
  String get how_to_get {
    return Intl.message(
      'How to get?',
      name: 'how_to_get',
      desc: '',
      args: [],
    );
  }

  /// `Scroll to see more`
  String get scroll_to_see {
    return Intl.message(
      'Scroll to see more',
      name: 'scroll_to_see',
      desc: '',
      args: [],
    );
  }

  /// `5 seconds forward`
  String get add_time_audio {
    return Intl.message(
      '5 seconds forward',
      name: 'add_time_audio',
      desc: '',
      args: [],
    );
  }

  /// `5 seconds back`
  String get substract_time_audio {
    return Intl.message(
      '5 seconds back',
      name: 'substract_time_audio',
      desc: '',
      args: [],
    );
  }

  /// `Select the language`
  String get selected_language {
    return Intl.message(
      'Select the language',
      name: 'selected_language',
      desc: '',
      args: [],
    );
  }

  /// `Language has been changed successfully`
  String get selected_language_text {
    return Intl.message(
      'Language has been changed successfully',
      name: 'selected_language_text',
      desc: '',
      args: [],
    );
  }

  /// `This application has been developed with the aim of making known the history of Martos, through the narration of different monuments and places of interest in the city.`
  String get info_text {
    return Intl.message(
      'This application has been developed with the aim of making known the history of Martos, through the narration of different monuments and places of interest in the city.',
      name: 'info_text',
      desc: '',
      args: [],
    );
  }

  /// `Martos Routes`
  String get routes_title {
    return Intl.message(
      'Martos Routes',
      name: 'routes_title',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next_monument {
    return Intl.message(
      'Next',
      name: 'next_monument',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous_monument {
    return Intl.message(
      'Previous',
      name: 'previous_monument',
      desc: '',
      args: [],
    );
  }

  /// `Developers`
  String get developers {
    return Intl.message(
      'Developers',
      name: 'developers',
      desc: '',
      args: [],
    );
  }

  /// `In collaboration with`
  String get colaborations {
    return Intl.message(
      'In collaboration with',
      name: 'colaborations',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get spanish {
    return Intl.message(
      'Spanish',
      name: 'spanish',
      desc: '',
      args: [],
    );
  }

  /// `Child`
  String get lang_boy {
    return Intl.message(
      'Child',
      name: 'lang_boy',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'boy'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
