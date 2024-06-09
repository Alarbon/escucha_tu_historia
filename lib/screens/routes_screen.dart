import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:escucha_tu_historia/models/routes.dart';
import 'package:escucha_tu_historia/providers/routes_provider.dart';
import 'package:escucha_tu_historia/providers/settings_provider.dart';
import 'package:escucha_tu_historia/widgets/custom_app_bar_widget.dart';
import 'package:escucha_tu_historia/widgets/drawer_widget.dart';
import 'package:escucha_tu_historia/widgets/loading_circulator.dart';
import 'package:escucha_tu_historia/widgets/open_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settingProvider = Provider.of<SettingsProvider>(context);
    final routesProvider = Provider.of<RoutesProvider>(context);

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
                child: Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: settingProvider.darkMode
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      S.current.routes_title,
                      style: TextStyle(
                        fontSize: size.width * 0.1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.4,
                child: SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.55,
                  child: routesProvider.routes == null
                      ? LoadingCirculator(size: size)
                      : ListView.builder(
                          itemCount: routesProvider.routes!.length,
                          itemBuilder: (context, index) {
                            Routes route = routesProvider.routes![index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: settingProvider.darkMode
                                      ? Colors.black.withOpacity(0.5)
                                      : Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    routesProvider.iconRoutes[route.type],
                                    size: size.width * 0.1,
                                  ),
                                  title: Text(
                                    route.name ?? '???',
                                    style: TextStyle(
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  subtitle: Text(
                                    route.description ?? '???',
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  onTap: () {
                                    routesProvider.routeValue = route;
                                    context.push('/routeDetail');
                                  },
                                ),
                              ),
                            );
                          },
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
