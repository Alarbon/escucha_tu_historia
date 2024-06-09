import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingsProvider>(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: settingProvider.darkMode
              ? const Color(0xff004832)
              : const Color(0xff00ba8a),
        ),
        child: ListTileTheme(
          textColor:
              settingProvider.darkMode ? Colors.white : const Color(0xff333333),
          iconColor:
              settingProvider.darkMode ? Colors.white : const Color(0xff333333),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/escudo_de_martos.png',
                  scale: 22,
                ),
              ),
              ListTile(
                onTap: () {
                  settingProvider.isHomeScreen = true;
                  settingProvider.advancedDrawerController.toggleDrawer();
                  context.go('/home');
                },
                leading: const Icon(FontAwesomeIcons.house),
                title: Text(S.current.home),
              ),
              ListTile(
                onTap: () {
                  settingProvider.isHomeScreen = false;
                  settingProvider.advancedDrawerController.toggleDrawer();
                  context.go('/routes');
                },
                leading: const Icon(FontAwesomeIcons.mapLocationDot),
                title: Text(S.current.routes),
              ),
              ListTile(
                onTap: () {
                  settingProvider.advancedDrawerController.toggleDrawer();
                  context.go('/settings');
                },
                leading: const Icon(FontAwesomeIcons.gear),
                title: Text(S.current.settings),
              ),
              ListTile(
                onTap: () {
                  settingProvider.advancedDrawerController.toggleDrawer();
                  context.go('/info');
                },
                leading: const Icon(FontAwesomeIcons.circleInfo),
                title: Text(S.current.about),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text(
                    '${S.current.version} ${settingProvider.version}',
                    style: TextStyle(
                      fontSize: 12,
                      color: settingProvider.darkMode
                          ? Colors.white54
                          : Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
