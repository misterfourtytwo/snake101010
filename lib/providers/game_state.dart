import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/models/bounty.dart';
import 'package:snake101010/models/my_point.dart';
import 'package:snake101010/models/snake.dart';
import 'package:snake101010/providers/config.dart';

class GameState {
  Config config = GetIt.I<Config>();

  Snake snake;
  Bounty bounty;
  Random _rand;
  ValueNotifier<int> score;
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
  }

  MyPoint emptySpot() {
    MyPoint newLocation;
    do {
      int bp = _rand.nextInt(config.fieldArea - snake.length);
      newLocation = MyPoint(bp % config.fieldWidth, bp ~/ config.fieldWidth);
    } while (snake.contains(newLocation));
    return newLocation;
  }

  Bounty nextBounty() => Bounty(emptySpot(),
      number: bounty.number + 1,
      isMega: (++bounty.number % 8 == 0) ? true : false);

  nextTick() {
    if (!snake.moving) return;
    bounty.tick++;
    if (snake.addHead() == bounty.location) {
      print('ate bounty');
      score.value += (bounty.isMega ? config.fieldArea ~/ bounty.tick + 1 : 1) *
          config.speed;
      print('id:${bounty.number}, mega: ${bounty.isMega}');
      bounty = nextBounty();
    } else {
      // saveHighscore(score);
      snake.dropTail();
    }
  }
}
