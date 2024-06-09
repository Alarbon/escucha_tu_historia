import 'package:escucha_tu_historia/models/routes.dart';
import 'package:escucha_tu_historia/services/routes_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoutesProvider extends ChangeNotifier {
  final RoutesService _routesService = RoutesService();

  Map<String, IconData> iconRoutes = {
    "iglesia": FontAwesomeIcons.church,
    "miradores": FontAwesomeIcons.panorama,
  };
  List<Routes>? _routes;
  Routes? _route;

  List<Routes>? get routes => _routes;

  Routes? get route => _route;

  set routeValue(Routes value) {
    _route = value;
    notifyListeners();
  }

  RoutesProvider() {
    getRoutes();
  }

  void getRoutes() async {
    _routes = await _routesService.getAllRoutes();
    notifyListeners();
  }
}
