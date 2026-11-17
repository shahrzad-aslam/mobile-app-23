import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/dashboard.dart';
import '../screens/app_info.dart';
import '../screens/radar.dart';
import '../screens/splash.dart';
import '../screens/login.dart';

class PageNames {
  static const String splash = "/";
  static const String login = "/login";
  static const String dashboard = "/dashboard";
  static const String radar = "/radar";
  static const String developer = "/app-info";
}

class AppRouter {
  static final GoRouter router = GoRouter (
    initialLocation: PageNames.splash,
    routes: [
      GoRoute(
        path: PageNames.splash,
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: PageNames.login,
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: PageNames.radar,
        builder: (context, state) {
          return RadarScreen();
        },
      ), 
      GoRoute(
        path: "${PageNames.dashboard}/:name",
        builder: (context, state) {
          final name = state.pathParameters["name"] ?? "Guest";
          return Dashboard(player: name);
        },
      ), 
      GoRoute(
        path: PageNames.developer,
        builder: (context, state) {
          return AppInfoScreen();
        },
      )
    ]
  );
}