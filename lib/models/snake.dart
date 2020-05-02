import 'package:get_it/get_it.dart';

import 'package:snake101010/models/my_point.dart';
import 'package:snake101010/providers/config.dart';

enum Direction { up, right, down, left }

class Snake {
  Direction direction;
  List<MyPoint> body;
  bool moving, dead;
  Config config;

  Snake({this.body, this.direction, this.moving, this.dead}) {
    config = GetIt.I<Config>();
    dead = dead ?? false;
    moving = moving ?? true;
    direction = direction ?? Direction.right;
    body = body ??
        [
          MyPoint(config.fieldWidth ~/ 2, config.fieldHeight ~/ 2),
          MyPoint(config.fieldWidth ~/ 2, config.fieldHeight ~/ 2 + 1),
          // MyPoint(config.fieldWidth ~/ 2 + 1, config.fieldHeight ~/ 2 + 1)
        ];
  }
  MyPoint get head => body.first;
  int get length => body.length;

  bool contains(MyPoint point) => body.contains(point);
  MyPoint nextHead() {
    MyPoint nextHead = MyPoint(head.x, head.y);
    switch (direction) {
      case Direction.up:
        nextHead.y = (config.fieldHeight + nextHead.y - 1) % config.fieldHeight;
        break;
      case Direction.right:
        nextHead.x = (config.fieldWidth + nextHead.x + 1) % config.fieldWidth;
        break;
      case Direction.down:
        nextHead.y = (config.fieldHeight + nextHead.y + 1) % config.fieldHeight;
        break;
      case Direction.left:
      default:
        nextHead.x = (config.fieldWidth + nextHead.x - 1) % config.fieldWidth;
    }
    return nextHead;
  }

  bool addHead(MyPoint nextHead) {
    if (contains(nextHead)) {
      dead = true;
      return false;
    } else {
      body.insert(0, nextHead);
      return true;
    }
  }

  void dropTail() {
    if (!dead) body.removeLast();
  }
}
