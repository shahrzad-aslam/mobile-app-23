import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/dashboard.dart';
import '../screens/score_board.dart';
import '../screens/developer_info.dart';
import '../screens/game_end.dart';
import '../screens/game.dart';
import '../screens/splash.dart';
import '../screens/user_name.dart';

class PageNames {
  static const String splash = "/";
  static const String userInput = "/user";
  static const String dashboard = "/dashboard";
  static const String scoreBoard = "/score-board";
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
        path: "${PageNames.dashboard}/:name",
        builder: (context, state) {
          final name = state.pathParameters["name"] ?? "Guest";
          return Dashboard(player: name);
        },
      ),
      GoRoute(
        path: "${PageNames.game}/:name",
        builder: (context, state) {
          final name = state.pathParameters["name"] ?? "Guest";
          return GameScreen(player: name);
        },
      ), 
      GoRoute(
        path: PageNames.scoreBoard,
        builder: (context, state) {
          return ScoreBoardScreen();
        },
      ), 
      GoRoute(
        path: "${PageNames.endGame}/:name/:score",
        builder: (context, state) {
          final name = state.pathParameters["name"] ?? "Guest";
          final score = state.pathParameters["score"] ?? "0";
          return GameEndScreen(playerName:  name, playerScore: score);
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