import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class LanguageConfig {
  static const double width = 32;
  static const double height = 32;

   static List<String> operativeLanguages = [
    'en',
    'es',
    'boy',
  ];

  static final Map<String, Widget> _languageMapIcon = {
    'es': CountryFlag.fromLanguageCode('es', width: width, height: height),
    'en': CountryFlag.fromLanguageCode('en', width: width, height: height),
    'boy': Image.asset('assets/images/boy.png', width: width, height: height)
  };

 
  static Widget getLanguageIcon(String languageCode) {
    return _languageMapIcon[languageCode.toLowerCase()] ??
        CountryFlag.fromLanguageCode('es' , width: width, height: height);
  }

  

}


