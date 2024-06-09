import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:escucha_tu_historia/widgets/change_language_widget.dart';
import 'package:escucha_tu_historia/widgets/custom_app_bar_widget.dart';
import 'package:escucha_tu_historia/widgets/drawer_widget.dart';
import 'package:escucha_tu_historia/widgets/open_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settingProvider = Provider.of<SettingsProvider>(context);

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff036242).withOpacity(0.5),
        ),
      ),
      controller: settingProvider.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const DrawerWidget(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: const AssetImage('assets/images/background_martos.jpg'),
              fit: BoxFit.cover,
              opacity: settingProvider.darkMode ? 0.25 : 0.5,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: size.height * 0.045,
                left: size.width * 0.04,
                child: OpenDrawerWidget(size: size),
              ),
              Positioned(
                top: size.height * 0.045,
                right: size.width * 0.04,
                child: Container(
                  decoration: BoxDecoration(
                    color: !settingProvider.darkMode
                        ? const Color(0xff14141c)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    iconSize: size.width * 0.08,
                    color: settingProvider.darkMode
                        ? const Color(0xffff9159)
                        : const Color(0xff985fff),
                    icon: Icon(settingProvider.darkMode
                        ? Icons.light_mode
                        : Icons.dark_mode),
                    onPressed: () {
                      settingProvider.toggleTheme();
                    },
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.12,
                child: SizedBox(
                  width: size.width * 0.95,
                  height: size.height * 0.85,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: size.height * 0.85,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AboutWidget(),
                          ChangeLanguageWidget(
                              size: size, settingProvider: settingProvider),
                        ],
                      ),
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

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settingProvider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 100,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: size.width * 0.7,
              child: CustomAppbarIcon(size: size * 0.9)),
          const SizedBox(height: 20.0),
          Text(
            settingProvider.nameApp,
            style: TextStyle(
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Text(
            '${S.current.version}: ${settingProvider.version}',
            style: TextStyle(fontSize: size.width * 0.033, color: Colors.white),
          ),
          const SizedBox(height: 5.0),
          Text(
            'Build number: ${settingProvider.buildNumber}',
            style: TextStyle(fontSize: size.width * 0.033, color: Colors.white),
          ),
          const SizedBox(height: 20.0),
          // Aquí puedes agregar más información si lo deseas
        ],
      ),
    );
  }
}
