import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/end_game_args.dart';
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
        path: "${PageNames.game}/:name",
        builder: (context, state) {
          final name = state.pathParameters["name"] ?? "Ali";
          return GameScreen(player: name);
        },
      ), 
      GoRoute(
        path: PageNames.endGame,
        builder: (context, state) {
          final endGameArgs = state.extra as EndGameArgs;
          return GameEndScreen(playerName:  endGameArgs.playerName, playerScore: endGameArgs.score);
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