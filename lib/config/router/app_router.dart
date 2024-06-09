import 'package:escucha_tu_historia/screens/detail_route_screen.dart';
import 'package:escucha_tu_historia/screens/info_screen.dart';
import 'package:escucha_tu_historia/screens/routes_screen.dart';
import 'package:escucha_tu_historia/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/detail_monument_screen.dart';
import '../../screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  errorPageBuilder: (context, state) => MaterialPage(
    child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Center(
            child: Text('Página de error: Ruta no encontrada'),
          ),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/home');
            },
            child: const Text('Ir al inicio'),
          ),
        ],
      ),
    ),
  ),
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: '/monumentDetail',
        builder: (context, state) => const DetailMonumentScreen()),
    GoRoute(
        path: '/settings', builder: (context, state) => const SettingScreen()),
    GoRoute(path: '/routes', builder: (context, state) => const RoutesScreen()),
    GoRoute(
        path: '/routeDetail',
        builder: (context, state) => const DetailRouteScreen()),
    GoRoute(path: '/info', builder: (context, state) => const InfoScreen()),
  ],
);
