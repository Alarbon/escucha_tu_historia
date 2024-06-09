import 'package:escucha_tu_historia/config/language_config.dart';
import 'package:escucha_tu_historia/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OpenDrawerWidget extends StatelessWidget {
  const OpenDrawerWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingsProvider>(context);
    return Row(
      children: [
        IconButton(
          onPressed: (){
           settingProvider.advancedDrawerController.toggleDrawer();
          },
          icon: ValueListenableBuilder<AdvancedDrawerValue>(
            valueListenable: settingProvider.advancedDrawerController,
            builder: (_, value, __) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  value.visible
                      ? FontAwesomeIcons.xmark
                      : FontAwesomeIcons.bars,
                  key: ValueKey<bool>(value.visible),
                  color: Colors.white,
                  size: size.width * 0.08,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        LanguageConfig.getLanguageIcon(settingProvider.selectedLanguage),
      ],
    );
  }
}
