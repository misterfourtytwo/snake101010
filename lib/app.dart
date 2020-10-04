import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snake101010/exports.dart';
import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/state_provider.dart';
import 'package:snake101010/view/game/view.dart';
import 'package:snake101010/view/menu.dart';
import 'package:snake101010/view/scoreboard.dart';
import 'package:snake101010/view/settings.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider.of<ConfigProvider>(ConfigProvider())],
      child: MaterialApp(
        // showPerformanceOverlay: true,
        title: "Snake",
        theme: ThemeData(
          backgroundColor: Colors.black,
          fontFamily: 'VT323',
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
              sl<GameStateProvider>().newGame();
            return GameView();
          },
          '/scoreboard': (context) => ScoreboardView(),
          '/settings': (context) => SettingsView(),
        },
        // color: Colors.black,
      ),
    );
  }
}
