import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/models/scoreboard.dart';
import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/game_state.dart';
import 'package:snake101010/view/game/view.dart';
import 'package:snake101010/view/menu.dart';
import 'package:snake101010/view/scoreboard.dart';
import 'package:snake101010/view/settings.dart';

void main() {
  // _initDb();
  _initServices();
  runApp(Main());
}

_initServices() {
  final _sl = GetIt.instance;
  _sl.registerSingleton<Config>(Config());
  _sl.registerSingleton<GameState>(GameState());
  _sl.registerSingleton<ScoreBoard>(ScoreBoard());
}

class Main extends StatelessWidget {
  const Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      title: "Snake",
      theme: ThemeData(
        fontFamily: 'VT323',
      ),
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => MenuView(),
        '/game': (context) => GameView(),
        '/scoreboard': (context) => ScoreboardView(),
        '/settings': (context) => SettingsView(),
      },
      // color: Colors.black,
    );
  }
}
