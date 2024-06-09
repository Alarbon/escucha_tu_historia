import 'package:escucha_tu_historia/providers/monuments_provider.dart';
import 'package:escucha_tu_historia/providers/settings_provider.dart';
import 'package:escucha_tu_historia/share_preferences/preferences.dart';
import 'package:escucha_tu_historia/widgets/loading_circulator.dart';
import 'package:escucha_tu_historia/widgets/open_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/card_monument_widget.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settingProvider = Provider.of<SettingsProvider>(context);
    final monumentsProvider = Provider.of<MonumentsProvider>(context);

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
                  top: size.height * 0.11, child: CustomAppbarIcon(size: size)),
              Positioned(
                top: size.height * 0.3,
                child: SizedBox(
                  width: size.width * 0.99,
                  height: size.height * 0.7,
                  child: monumentsProvider
                              .monumentsReduced[Preferences.language] ==
                          null
                      ? LoadingCirculator(size: size)
                      : GridView.builder(
                          itemCount: monumentsProvider
                              .monumentsReduced[Preferences.language]!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (_, index) => CardMonument(
                            monument: monumentsProvider
                                .monumentsReduced[Preferences.language]![index],
                            size: size,
                            onTap: () {
                              monumentsProvider.getMonument(
                                monumentsProvider
                                    .monumentsReduced[Preferences.language]![
                                        index]
                                    .number!,
                              );
                              context.push('/monumentDetail');
                            },
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
