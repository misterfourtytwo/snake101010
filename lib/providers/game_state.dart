import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/models/bounty.dart';
import 'package:snake101010/models/my_point.dart';
import 'package:snake101010/models/scoreboard.dart';
import 'package:snake101010/models/snake.dart';
import 'package:snake101010/providers/config.dart';

enum ControlActions {
  MoveUp,
  MoveRight,
  MoveDown,
  MoveLeft,
  TogglePause,

  /// restart game
  Restart,

  /// leave screen with game field
  LeaveField,

  /// leave screen with game field and reset game
  EndGame,
}

class GameState {
  Random _rand;

  Config config = GetIt.I<Config>();

  Snake snake;
  Bounty bounty;
  ValueNotifier<int> score;
  bool paused;
  ControlActions lastAction;
  DateTime _lastPauseToggle;

  // int get score => score.value;
  setScore(int newValue) => score.value = newValue;

  GameState() {
    _rand = Random(DateTime.now().millisecondsSinceEpoch);
    score = ValueNotifier<int>(0);
    reset();
  }

  reset() {
    snake = Snake();
    bounty = Bounty(emptySpot());
    score.value = 0;
    paused = true;
    lastAction = null;
    _tickLock = false;
    _tick = 0;
    _lastTick = -1;

    _lastPauseToggle = DateTime.now();
  }

  dispose() {
    score.dispose();
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
        isMega: (bounty.number % Config.bountyFrequency ==
                Config.bountyFrequency - 1)
            ? true
            : false,
      );

  void setAction(ControlActions action) {
    print('Set action $action');
    switch (action) {
      case (ControlActions.LeaveField):
        //TODO add some handlers???
        lastAction = action;
        break;
      case (ControlActions.EndGame):
      case (ControlActions.Restart):
        GetIt.I<ScoreBoard>()
            .pushScore(Score(value: score.value, playerName: 'PLAYER'));
        reset();
        break;

      case (ControlActions.TogglePause):
        if (DateTime.now().difference(_lastPauseToggle).inMilliseconds > 500) {
          print('togglePause');
          lastAction = ControlActions.TogglePause;
          _lastPauseToggle = DateTime.now();
        }
        break;
      default:
        if (!(paused ||
            snake.dead ||
            Direction.values[(action.index + 2) % 4] == snake.direction))
          lastAction = action;
    }
  }

  bool _tickLock;
  int _tick;
  // last tick when we moved snake
  int _lastTick;

  /// update state on tick
  void nextTick() {
    // check whether last tick aren't finished yet
    if (_tickLock) return;
    _tickLock = true;
    _tick++;
    // check whether we need to move snake
    // 25 ticks per second, config.speed updates per one
    // dTicks * .04 sec < 1.0 sec / config.speed
    if ((_tick - _lastTick) * config.speed < Config.fps) {
      // print('skip tick');
      _tickLock = false;
      return;
    }
    // print('tick');
    _lastTick = _tick;

    if (paused) {
      if (lastAction == null) {
      } else if (lastAction == ControlActions.TogglePause) {
        paused = false;
        lastAction = null;
        move();
      } else if (lastAction == ControlActions.LeaveField) {
        paused = true;
      }
      lastAction = null;
      _tickLock = false;
      return;
    } else {
      // print('not paused');
      print('last action: $lastAction');
      if (lastAction != null) {
        if (lastAction.index < 4)
          snake.direction = Direction.values[lastAction.index];
        else if (lastAction == ControlActions.TogglePause)
          paused = true;
        else if (lastAction == ControlActions.LeaveField) paused = true;

        lastAction = null;
      }
      move();
    }
    _tickLock = false;
  }

  void move() {
    if (paused) return;
    bounty.tick++;

    final nextHead = snake.nextHead();
    if (nextHead != bounty.location) {
      snake.dropTail();
      if (!snake.addHead(nextHead)) paused = true;
    } else {
      score.value += (bounty.isMega ? config.fieldArea ~/ bounty.tick + 1 : 1) *
          config.speed;
      snake.addHead(nextHead);
      bounty = nextBounty();
    }
  }
}
