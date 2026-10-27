import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/developer_info.dart';
import '../screens/game_end.dart';
import '../screens/game.dart';
import '../screens/splash.dart';
import '../screens/user_name.dart';

class PageNames {
  static const String splash = "/";
  static const String userInput = "/user";
  static const String game = "/game";
  static const String endGame = "/end-game";
  static const String developer = "/developer-info";
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
        path: PageNames.userInput,
        builder: (context, state) {
          return UserNameScreen();
        },
      ),
      GoRoute(
        path: PageNames.game,
        builder: (context, state) {
          return GameScreen();
        },
      ), 
      GoRoute(
        path: PageNames.endGame,
        builder: (context, state) {
          return GameEndScreen();
        },
      ),
      GoRoute(
        path: PageNames.developer,
        builder: (context, state) {
          return DeveloperInfoScreen();
        },
      )
    ]
  );
}