import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/models/bounty.dart';
import 'package:snake101010/models/my_point.dart';
import 'package:snake101010/models/snake.dart';
import 'package:snake101010/providers/config.dart';

enum ControlActions {
  PauseToggle,
  MoveUp,
  MoveRight,
  MoveDown,
  MoveLeft,
}

class GameState {
  Random _rand;

  Config config = GetIt.I<Config>();

  Snake snake;
  Bounty bounty;
  ValueNotifier<int> score;
  bool paused;
  ControlActions lastAction;

  // int get score => score.value;
  setScore(int newValue) => score.value = newValue;

  GameState() {
    _rand = Random(DateTime.now().millisecondsSinceEpoch);
    score = ValueNotifier<int>(0);
    reset();
  }

  dispose() {
    score.dispose();
  }

  reset() {
    snake = Snake();
    bounty = Bounty(emptySpot());
    score.value = 0;
    paused = true;
    lastAction = null;
  }

  MyPoint emptySpot() {
    MyPoint newLocation;
    do {
      int bp = _rand.nextInt(config.fieldArea - snake.length);
      newLocation = MyPoint(bp % config.fieldWidth, bp ~/ config.fieldWidth);
    } while (snake.contains(newLocation));
    return newLocation;
  }

  // create next bounty object positioned in empty cell
  Bounty nextBounty() => Bounty(
        emptySpot(),
        number: bounty.number + 1,
        isMega: (bounty.number % config.bountyFrequency ==
                config.bountyFrequency - 1)
            ? true
            : false,
      );

  bool _tickLock = false;
  int _tick = 0;
  // last tick when we moved snake
  int _lastTick = -1;

  /// update state on tick
  void nextTick() {
    // check whether last tick aren't finished yet
    if (_tickLock || paused) return;
    _tickLock = true;

    _tick++;
    // check whether we need to move snake
    if (_tick - _lastTick < 1.0 / config.speed) {
      _tickLock = false;
      return;
    }
    _lastTick = _tick;
    bounty.tick++;

    if (snake.addHead() == bounty.location) {
      // print('ate bounty');
      score.value += (bounty.isMega ? config.fieldArea ~/ bounty.tick + 1 : 1) *
          config.speed;
      // print('id:${bounty.number}, mega: ${bounty.isMega}');
      bounty = nextBounty();
    } else {
      // saveHighscore(score);
      snake.dropTail();
    }
    _tickLock = false;
  }
}
