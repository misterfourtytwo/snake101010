import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/game_state.dart';
import 'package:snake101010/providers/scoreboard.dart';
import 'package:snake101010/view/game/view.dart';
import 'package:snake101010/view/menu.dart';
import 'package:snake101010/view/scoreboard.dart';
import 'package:snake101010/view/settings.dart';

void main() {
  // _initDb();
  _initServices();
  runApp(Main());
}

final _sl = GetIt.instance;
_initServices() {
  _sl.registerSingleton<Config>(Config());
  _sl.registerSingleton<GameState>(GameState());
  _sl.registerSingleton<ScoreBoard>(ScoreBoard());
}

class Main extends StatelessWidget {
  const Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: true,
      title: "Snake",
      theme: ThemeData(
        fontFamily: 'VT323',
        // iconTheme: IconThemeData(color: Colors.white, size: 64),

        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white)),
      ),
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => MenuView(),
        '/game': (context) {
          if (ModalRoute.of(context).settings.arguments != null &&
              ModalRoute.of(context).settings.arguments as bool)
            _sl<GameState>().reset();
          return GameView();
        },
        '/scoreboard': (context) => ScoreboardView(),
        '/settings': (context) => SettingsView(),
      },
      // color: Colors.black,
    );
  }
}
