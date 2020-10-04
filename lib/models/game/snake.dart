import 'dart:math';

import 'package:flutter/foundation.dart';

class Snake {
  List<Point<int>> body;
  bool isMoving, isDead;

  Snake(this.body, {this.isMoving, this.isDead}) {
    isDead = isDead ?? false;
    isMoving = isMoving ?? true;
    body = body;
  }

  Point get head => body.first;
  int get length => body.length;

  // Point nextHead() {
  //   int x = head.x;
  //   int y = head.y;
  //   switch (direction) {
  //     case Direction.up:
  //       y = (config.fieldHeight + y - 1) % config.fieldHeight;
  //       break;
  //     case Direction.right:
  //       x = (config.fieldWidth + x + 1) % config.fieldWidth;
  //       break;
  //     case Direction.down:
  //       y = (config.fieldHeight + y + 1) % config.fieldHeight;
  //       break;
  //     case Direction.left:
  //     default:
  //       x = (config.fieldWidth + x - 1) % config.fieldWidth;
  //   }

  //   return Point(x, y);
  // }

  void growTo(Point pos) {
    body.insert(0, pos);
  }

  void pop() {
    body.removeLast();
  }
}
