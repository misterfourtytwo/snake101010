import 'package:snake101010/config.dart';
import 'package:snake101010/models/my_point.dart';

enum Direction { up, right, down, left }

class Snake {
  List<MyPoint> body;
  Direction direction;
  bool moving, dead;

  Snake({this.body, this.direction, this.moving}) {
    dead = dead ?? false;
    moving = moving ?? true;
    body = body ??
        [
          MyPoint(Config.fieldWidth ~/ 2 + 1, Config.fieldHeight ~/ 2 + 1),
          MyPoint(Config.fieldWidth ~/ 2 + 1, Config.fieldHeight ~/ 2 + 2),
          MyPoint(Config.fieldWidth ~/ 2 + 2, Config.fieldHeight ~/ 2 + 2)
        ];
  }
  MyPoint get head => body.first;
  int get length => body.length;

  bool contains(MyPoint point) => body.contains(point);

  MyPoint addHead() {
    MyPoint nh = MyPoint(head.x, head.y);
    switch (direction) {
      case Direction.up:
        nh.y = (Config.fieldHeight + nh.y - 1) % Config.fieldHeight;
        break;
      case Direction.right:
        nh.x = (Config.fieldWidth + nh.x + 1) % Config.fieldWidth;
        break;
      case Direction.down:
        nh.y = (Config.fieldHeight + nh.y + 1) % Config.fieldHeight;
        break;
      case Direction.left:
      default:
        nh.x = (Config.fieldWidth + nh.x - 1) % Config.fieldWidth;
    }
    if (contains(nh)) {
      dead = true;
      moving = false;
    } else {
      body.insert(0, nh);
    }
    return head;
  }

  void dropTail() {
    if (!dead) body.removeLast();
  }
}
