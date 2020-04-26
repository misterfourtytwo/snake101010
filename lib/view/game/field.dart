import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/game_state.dart';
import 'package:snake101010/utils/bg_painter.dart';
import 'package:snake101010/utils/snake_painter.dart';

class GameField extends StatefulWidget {
  GameField({Key key}) : super(key: key);

  @override
  _GameFieldState createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  Config config;
  GameState state;

  SnakePainter snakePainter;
  BgPainter bgPainter;

  Timer timer;

  @override
  void initState() {
    super.initState();

    config = GetIt.I<Config>();
    state = GetIt.I<GameState>();

    bgPainter = BgPainter();
    snakePainter = SnakePainter();

    timer = new Timer.periodic(
      Duration(milliseconds: 1000 ~/ config.speed),
      (Timer t) => setState(state.nextTick),
      // snakePainter.tick(snake, bounty, timer.tick);
    );
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: ValueKey(timer.tick),
      size: config.size,
      painter: bgPainter,
      foregroundPainter: snakePainter,
    );
  }
}
