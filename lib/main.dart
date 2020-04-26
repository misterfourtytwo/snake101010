import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/game_state.dart';
import 'package:snake101010/view/menu.dart';

void main() {
  // _initDb();
  _initServices();

  runApp(Game());
}

_initServices() {
  final _sl = GetIt.instance;
  _sl.registerSingleton<Config>(Config());
  _sl.registerSingleton<GameState>(GameState());
}

class Game extends StatelessWidget {
  const Game({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Snake",
      home: MenuView(),
      color: Colors.black,
    );
  }
}
