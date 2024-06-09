import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:escucha_tu_historia/models/monument_reduced.dart';
import 'package:escucha_tu_historia/providers/monuments_provider.dart';
import 'package:escucha_tu_historia/providers/routes_provider.dart';
import 'package:escucha_tu_historia/providers/settings_provider.dart';
import 'package:escucha_tu_historia/widgets/card_monument_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailRouteScreen extends StatelessWidget {
  const DetailRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final monumentsProvider = Provider.of<MonumentsProvider>(context);
    final routeProvider = Provider.of<RoutesProvider>(context);

    final List<MonumentReduced>? monuments =
        monumentsProvider.getMonumentsByRoute(routeProvider.route!.monuments!);

    return Scaffold(
        body: monuments == null
            ? Center(
                child: SizedBox(
                  width: size.width * 0.2,
                  height: size.width * 0.2,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.black38,
                    strokeWidth: 6,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              )
            : RouteData(size: size, monuments: monuments));
  }
}

class RouteData extends StatelessWidget {
  const RouteData({
    super.key,
    required this.size,
    required this.monuments,
  });

  final Size size;
  final List<MonumentReduced>? monuments;

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RoutesProvider>(context);
    final monumentsProvider = Provider.of<MonumentsProvider>(context);
    final settingProvider = Provider.of<SettingsProvider>(context);

    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: const AssetImage('assets/images/background_martos.jpg'),
          fit: BoxFit.cover,
          opacity: settingProvider.darkMode ? 0.25 : 0.5,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: size.height * 0.03,
            left: size.width * 0.03,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                context.go('/routes');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                     Icon(FontAwesomeIcons.arrowLeftLong,
                        size: size.width * 0.08, color: Colors.white),

                    const SizedBox(width: 10),
                    Text(
                      S.current.back,
                      style:  TextStyle(fontSize: size.width * 0.05),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.1,
            left: size.width * 0.03,
            child: Container(
              width: size.width * 0.95,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: settingProvider.darkMode
                    ? Colors.black.withOpacity(0.5)
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(routeProvider.iconRoutes[routeProvider.route!.type]!,
                        size: size.width * 0.2,
                        color: settingProvider.darkMode
                            ? Colors.white
                            : Colors.black),
                    const SizedBox(height: 30),
                    Text(
                      routeProvider.route!.name!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.06,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.37,
            left: size.width * 0.05,
            child: SizedBox(
              width: size.width * 0.9,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: settingProvider.darkMode
                          ? Colors.black.withOpacity(0.7)
                          : Colors.white.withOpacity(0.7),
                      blurRadius: 100,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  routeProvider.route!.description ?? 'No description',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.43,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.53,
              child: GridView.builder(
                itemCount: monuments?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, index) {
                  final monument = monuments?[index];
                  return CardMonument(
                    monument: monument!,
                    size: size,
                    onTap: () {
                      monumentsProvider.getMonument(monument.number!);
                      context.push('/monumentDetail');
                    },
                  );
                },
              ),
            ),
          ),
          // Add description and monument cards here
        ],
      ),
    );
  }
}
