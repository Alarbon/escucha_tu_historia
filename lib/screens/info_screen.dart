import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:escucha_tu_historia/providers/settings_provider.dart';
import 'package:escucha_tu_historia/widgets/drawer_widget.dart';
import 'package:escucha_tu_historia/widgets/open_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

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
                top: size.height * 0.15,
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.75,
                  decoration: BoxDecoration(
                    color: settingProvider.darkMode
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.info_text,
                            style:  TextStyle(
                              fontSize: size.width * 0.045,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: size.height * 0.05),
                          Text(
                            "${S.current.developers}:",
                            style: TextStyle(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              SocialWidget(
                                  icon: FontAwesomeIcons.linkedin,
                                  size: size,
                                  onTap: () async {
                                    final Uri url = Uri.parse(
                                        'https://www.linkedin.com/in/alarbon/');
                                    launchUrl(url);
                                  },
                                  name: "Adrián Lara Bonilla"),
                              SocialWidget(
                                  icon: FontAwesomeIcons.linkedin,
                                  size: size,
                                  onTap: () async {
                                    final Uri url = Uri.parse(
                                        'https://www.linkedin.com/in/rzucar/');
                                    launchUrl(url);
                                  },
                                  name: "Raúl Zúcar Aceituno"),
                              // Add more GestureDetector widgets for other developers
                            ],
                          ),
                          SizedBox(height: size.height * 0.05),
                          Text(
                            "${S.current.colaborations}:",
                            style: TextStyle(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              SocialWidget(
                                  icon: FontAwesomeIcons.school,
                                  size: size,
                                  onTap: () async {
                                    final Uri url = Uri.parse(
                                        'https://web.iesfernandoiii.es');
                                    launchUrl(url);
                                  },
                                  name: "I.E.S. Fernando III de Martos"),

                              SocialWidget(
                                  icon: FontAwesomeIcons.placeOfWorship,
                                  size: size,
                                  onTap: () async {
                                    final Uri url =
                                        Uri.parse('https://martos.es');
                                    launchUrl(url);
                                  },
                                  name: "Ayuntamiento de Martos"),
                              // Add more GestureDetector widgets for other developers
                            ],
                          ),
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

class SocialWidget extends StatelessWidget {
  const SocialWidget({
    super.key,
    required this.size,
    required this.onTap,
    required this.name,
    required this.icon,
  });

  final Size size;
  final VoidCallback onTap;
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(width: size.width * 0.02),
            Icon(icon),
            SizedBox(width: size.width * 0.04),
            Text(
              name,
              style: TextStyle(
                fontSize: size.width * 0.04,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
