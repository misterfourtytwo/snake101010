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
          MyPoint(config.fieldWidth ~/ 2 + 1, config.fieldHeight ~/ 2 + 1)
        ];
  }
  MyPoint get head => body.first;
  int get length => body.length;

  bool contains(MyPoint point) => body.contains(point);

  MyPoint addHead() {
    MyPoint newHead = MyPoint(head.x, head.y);
    switch (direction) {
      case Direction.up:
        newHead.y = (config.fieldHeight + newHead.y - 1) % config.fieldHeight;
        break;
      case Direction.right:
        newHead.x = (config.fieldWidth + newHead.x + 1) % config.fieldWidth;
        break;
      case Direction.down:
        newHead.y = (config.fieldHeight + newHead.y + 1) % config.fieldHeight;
        break;
      case Direction.left:
      default:
        newHead.x = (config.fieldWidth + newHead.x - 1) % config.fieldWidth;
    }
    if (contains(newHead) && newHead != body.last) {
      dead = true;
      moving = false;
    } else {
      body.insert(0, newHead);
    }
    return head;
  }

  void dropTail() {
    if (!dead) body.removeLast();
  }
}
