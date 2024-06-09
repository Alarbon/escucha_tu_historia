import 'package:escucha_tu_historia/config/language_config.dart';
import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:escucha_tu_historia/providers/monuments_provider.dart';
import 'package:escucha_tu_historia/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({
    super.key,
    required this.size,
    required this.settingProvider,
  });

  final Size size;
  final SettingsProvider settingProvider;

  @override
  Widget build(BuildContext context) {
    final monumentsProvider = Provider.of<MonumentsProvider>(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            S.current.selected_language,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.08,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: size.width * 0.05,
          children: LanguageConfig.operativeLanguages.map((language) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: settingProvider.selectedLanguage == language
                    ? settingProvider.darkMode
                        ? const Color(0xff004832)
                        : Colors.green
                    : null,
              ),
              onPressed: () {
                if (settingProvider.selectedLanguage != language) {
                  settingProvider.changeLanguage(context, language);
                  monumentsProvider.getMonumentsReduced();
                  monumentsProvider.getAllMonuments();
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                child: SizedBox(
                  width: LanguageConfig.width - 5,
                  height: LanguageConfig.height - 5,
                  child: LanguageConfig.getLanguageIcon(language),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
